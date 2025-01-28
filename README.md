# stratus-tf-pat-ops-mon
This Terraform module creates a resource group, action group, and activity log alert for service health alerts in Azure.
It also creates a consumption budget with notifications.

## Required inputs

### General 
- **code_name**: The code name for the project
- **environment**: The environment the resources are being deployed to
- **location**: The location to deploy the resources to
- **subscription_id**: The subscription id to monitor
- **email_address**: The email addresses to send alerts and budget notifications to

### Service Health Alerts
- **services**: Services to create Service health alerts for
- **services_locations**: The locations of the services to monitor

### Budget
- **budget_amount**: Set a budget amount if a budget is to be created
- **budget_notifications_actual**: A list of percentage values, notifications will be sent when the budget exceed these percentages.
- **budget_notifications_forecasted**: A list of percentage values, notifications will be sent when the budget is forecasted to exceed these percentages.


## Usage

#### Example 1: Setting up service health alerts and a budget with notifications

```hcl
module "service_health_alerts" {
  source                          = "github.com/HafslundEcoVannkraft/stratus-tf-pat-ops-mon"
  code_name                       = "example"
  environment                     = "prod"
  location                        = "West Europe"
  email_address                   = ["alerts@example.com"]
  subscription_id                 = "00000000-0000-0000-0000-000000000000"
  services                        = ["Service1", "Service2"]
  services_locations              = ["West Europe", "East US"]
  budget_amount                   = 5000
  budget_notifications_actual     = [80, 100, 120]
  budget_notifications_forecasted = [100]
}
```

#### Example 2: Setting up only service health alerts
```hcl
module "service_health_alerts" {
  source                          = "github.com/HafslundEcoVannkraft/stratus-tf-pat-ops-mon"
  code_name                       = "example"
  environment                     = "prod"
  location                        = "West Europe"
  email_address                   = ["alerts@example.com"]
  subscription_id                 = "00000000-0000-0000-0000-000000000000"
  services                        = ["Service1", "Service2"]
  services_locations              = ["West Europe", "East US"]
}
```

#### Example 3: Setting up only a budget with notifications

```hcl
module "service_health_alerts" {
  source                          = "github.com/HafslundEcoVannkraft/stratus-tf-pat-ops-mon"
  code_name                       = "example"
  environment                     = "prod"
  location                        = "West Europe"
  email_address                   = ["alerts@example.com"]
  subscription_id                 = "00000000-0000-0000-0000-000000000000"
  budget_amount                   = 5000
  budget_notifications_actual     = [80, 100, 120]
  budget_notifications_forecasted = [100]
}
```


