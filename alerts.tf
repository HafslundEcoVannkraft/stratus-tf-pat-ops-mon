# Creates a resource group, action group and activity log alert for service health alerts

# The Resource Group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "service_health_alerts_rg" {
  count    = var.services != [] ? 1 : 0
  name     = "${var.code_name}-service-health-alerts-rg-${var.environment}"
  location = var.location
}

# The Action Group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_monitor_action_group" "service_health_action_group" {
  count               = var.services != [] ? 1 : 0
  name                = "${var.code_name}-${var.environment}-service_health_ag"
  resource_group_name = azurerm_resource_group.service_health_alerts_rg[0].name
  short_name          = "shalert"

  dynamic "email_receiver" {
    for_each = var.email_address
    content {
      name          = "SendToAlertDL-${email_receiver.value}"
      email_address = email_receiver.value
    }
  }
}

# The Activity Log Alert
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert
resource "azurerm_monitor_activity_log_alert" "main" {
  count               = var.services != [] ? 1 : 0
  name                = "${var.code_name}-${var.environment}-service_health_la"
  resource_group_name = azurerm_resource_group.service_health_alerts_rg[0].name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  description         = "This alert will monitor a specific subscription."
  location            = "global"

  criteria {
    category = "ServiceHealth"
    service_health {
      locations = var.services_locations
      services  = var.services
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.service_health_action_group[0].id
  }
  depends_on = [azurerm_monitor_action_group.service_health_action_group]
}