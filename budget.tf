# Creates a Budget and associated notifications

locals {
  # Create a map of notifications with threshold_type "Actual" from the given var.budget_notifications_actual
  notifications_actual = {for i in var.budget_notifications_forecasted : "actual${i}" => {
    enabled = true
    operator = "GreaterThan"
    threshold = i
    threshold_type = "Actual"
  }}
  # Create a map of notifications with threshold_type "Forecasted" from the given var.budget_notifications_forecasted
  notifications_forcasted = {for i in var.budget_notifications_actual : "forecast${i}" => {
    enabled = true
    operator = "GreaterThan"
    threshold = i
    threshold_type = "Forecasted"
  }}

  # Merge the two maps to create a single map of notifications for the budget
  notifications = merge(local.notifications_forcasted, local.notifications_actual)
}


resource "terraform_data" "input_variable_hash" {
  input = sha1(
      # if any of these variables change, the budget start and end date will be re-computed
      join("", [
        jsonencode(var.code_name),
        jsonencode(var.environment),
        jsonencode(var.email_address),
        jsonencode(var.subscription_id),
        jsonencode(var.budget_amount),
        jsonencode(var.budget_notifications_actual),
        jsonencode(var.budget_notifications_forecasted)
      ])
  )
}

# Time resources for setting budget start_date and end_date
resource "time_static" "current_time" {
  count = var.budget_amount != 0 ? 1 : 0
  lifecycle {
    replace_triggered_by = [terraform_data.input_variable_hash]
  }
}

resource "time_offset" "ten_years" {
  count = var.budget_amount != 0 ? 1 : 0
  offset_years = 10
  lifecycle {
    replace_triggered_by = [terraform_data.input_variable_hash]
  }
}

# Create the Budget resource
resource "azurerm_consumption_budget_subscription" "budget" {
    count           = var.budget_amount != 0 ? 1 : 0
    name            = "${var.code_name}-${var.environment}-budget"
    subscription_id = "/subscriptions/${var.subscription_id}"
    amount          = var.budget_amount
    time_grain      = "Monthly"

    time_period {
        start_date = formatdate("YYYY-MM-01'T'00:00:00Z", time_static.current_time[0].rfc3339)
        end_date   = time_offset.ten_years[0].rfc3339
    }

    dynamic "notification" {
        for_each = local.notifications 
            content {
                enabled        = notification.value.enabled
                threshold      = notification.value.threshold
                operator       = notification.value.operator
                threshold_type = notification.value.threshold_type
                contact_emails = var.email_address
            }
    }
}