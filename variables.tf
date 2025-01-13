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
  type        = set(string)

}

variable "email_address" {
  description = "The email address to send alerts to"
  type        = string
}

variable "subscription_id" {
  description = "The subscription id to monitor"
  type        = string
}

variable "services" {
  description = "The services to monitor"
  type        = list(string)
}