# Creates a resource group, action group and activity log alert for service health alerts

# The Resource Group
resource "azurerm_resource_group" "service_health_alerts_rg" {
  name     = "${var.code_name}-service-health-alerts-rg-${var.environment}"
  location = var.location
}

# The Action Group
resource "azurerm_monitor_action_group" "service_health_action_group" {
  name                = "${var.code_name}-${var.environment}-service_health_ag"
  resource_group_name = azurerm_resource_group.service_health_alerts_rg.name
  short_name          = "shalert"

  email_receiver {
    name          = "SendToAlertDL"
    email_address = var.email_address
  }
}

# The Activity Log Alert
resource "azurerm_monitor_activity_log_alert" "main" {
  name                = "${var.code_name}-${var.environment}-service_health_la"
  resource_group_name = azurerm_resource_group.service_health_alerts_rg.name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  description         = "This alert will monitor a specific subscription."
  location            = "global"

  criteria {
    category = "ServiceHealth"
    service_health {
      locations = var.location
      services  = var.services
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.service_health_action_group.id
  }
  depends_on = [azurerm_monitor_action_group.service_health_action_group]
}