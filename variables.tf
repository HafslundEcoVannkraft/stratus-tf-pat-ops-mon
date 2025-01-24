variable "code_name" {
  description = "The code name for the project"
  type        = string
}

variable "environment" {
  description = "The environment the resources are being deployed to"
  type        = string
}

variable "location" {
  description = "The location to deploy the resources to"
  type        = string
}

variable "email_address" {
  description = "The email address to send alerts to"
  type        = list(string)
}

variable "subscription_id" {
  description = "The subscription id to monitor"
  type        = string
}

variable "services" {
  description = "The services to monitor"
  type        = list(string)
}


variable "services_locations" {
  description = "The location to deploy the resources to"
  type        = list(string)

}
variable "budget_amount" {
  description = "The budget amount"
  type        = number
  default     = 0
}

variable "budget_notifications_actual" {
  type = list(number)
  description = "A list of percentage values (e.g., [80, 100, 120]), notifications will be sent when the budget exceed these percentages"
  default     = [80, 100, 120]
}

variable "budget_notifications_forecasted" {
  type = list(number)
  description = "A list of percentage values (e.g., [100]), notifications will be sent when the budget is forecasted to exceed these percentages"
  default     = [100]
}