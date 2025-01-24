# stratus-tf-pat-ops-mon
This Terraform module creates a resource group, action group, and activity log alert for service health alerts in Azure.
It also creates a consumption budget

## Required inputs

### General
- **code_name**: The code name for the project
- **environment**: The environment the resources are being deployed to
- **location**: The location to deploy the resources to

### Module specific
- **email_address**: The email address to send alerts and budget notifications to
- **subscription_id**: The subscription id to monitor
- **services**: The services to monitor
- **services_locations**: The locations of the services to monitor
- **budget_amount**: Set a budget amount if a budget is to be created
- **budget_notifications_actual**: A list of percentage values, notifications will be sent when the budget exceed these percentages.
- **budget_notifications_forecasted**: A list of percentage values, notifications will be sent when the budget is forecasted to exceed these percentages.


## Usage

```hcl
module "service_health_alerts" {
  source                          = "./path/to/module"
  code_name                       = "example"
  environment                     = "prod"
  location                        = "West Europe"
  email_address                   = "alerts@example.com"
  subscription_id                 = "00000000-0000-0000-0000-000000000000"
  services                        = ["Service1", "Service2"]
  services_locations              = ["West Europe", "East US"]
  budget_amount                   = 5000
  budget_notifications_actual     = [80, 100, 120]
  budget_notifications_forecasted = [100]
}


## NB Work in progress, do not use this module