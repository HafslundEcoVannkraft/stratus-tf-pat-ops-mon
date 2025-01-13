# stratus-tf-pat-ops-mon
This Terraform module creates a resource group, action group, and activity log alert for service health alerts in Azure.

## Required inputs

### General
- **code_name**: The code name for the project
- **environment**: The environment the resources are being deployed to
- **location**: The location to deploy the resources to

### Module specific
- **email_address**: The email address to send alerts to
- **subscription_id**: The subscription id to monitor
- **services**: The services to monitor
- **services_locations**: The locations of the services to monitor


## Usage

```hcl
module "service_health_alerts" {
  source            = "./path/to/module"
  code_name         = "example"
  environment       = "prod"
  location          = "West Europe"
  email_address     = "alerts@example.com"
  subscription_id   = "00000000-0000-0000-0000-000000000000"
  services          = ["Service1", "Service2"]
  services_locations = ["West Europe", "East US"]
}


## NB Work in progress, do not use this module