# TruckLots

This is the top-level Terraform project for provisioning infrastructure
for the Trucklots application.

## Layers

This AzureCICD project (azure-ci-cd) is broken into the following layers:

| **Layer**          | **Description**                                             |
|--------------------|-------------------------------------------------------------|
| Env                | It contains the Environment wise configurations.            |
| modules            | The associated modules related to CI/CD are placed herewith |


This Terraform project (azure-terraform)  is broken into the following layers:

| **Layer**          | **Description**                                            											 |
|--------------------|-------------------------------------------------------------											 |
| 000_main              | Initial boostrap layer for creating Terraform state storage 											 |
| 100_base           | Top level resources per environment (VNet, Subnet, Public IP, key-vault, Custom Roles)|
| 200_tenant_storage | Blob storage that is tenant specific (Storage Account, Container, Lifecycle Policy)                   |
| 300_database       | Operational databases and schema (SQL Server, SQL Database, Users(*), SQL Firewall)                   |
| 400_backend        | Micro-service support (Azure container app)                             	                 |
| 500_frontend       | User Interface (Static Web Apps, Application Gateway)												 |
| modules            | Private DNS Zone, EndPoint, Access Control, Application Insights    	            					 |

The terraform state is managed per layer and per environment to allow for
independent releases of the layers into their respective environments:

## Environments

| **Environment** | **Description**                |
|-----------------|--------------------------------|
| dev             | Development used by developers |
| qa              | Testing and quality assurance  |
| uat             | User acceptance testing        |
| prod            | Production                     |

## Azure Resource Naming Conventions

https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming

## First Deployment to an Environment

The very first time that Terraform is executed for a specific environment i.e. dev, qa, prod you will
need to run Terraform in the 000_main layer as shown below, but first you will need to log into azure,
or set your environment variables with credentials that will allow the Azure CLI to make changes:

```bash
$ az login
```

```bash
$ cd terraform/layers/000_main/Env/dev
$ terraform init
$ terraform apply -auto-approve
```

This will create the resource group and storage account and blob container that keeps track of the
remote Terraform state for the environment.  Multiple files will be created in this container, one
for each layer.

Note that by changing into the Env/dev folder the terraform command is using the provider and
variables from that folder, so you do not need to specify variables on the command line unless
you are overriding the variables.  The subscription ID is also set for each environment to
make sure that the proper subscription is chosen for where the resources are being deployed.

## Deployment to an Environment

Once the 000_main layer exists, it is recommended that you apply changes to the layer in numerical
order.  For example, changes to 100_base should be applied before 200_tenant_storage.  The reason that
the scripts are broken into different layers is to allow for independent deployment of the layers
without having to re-deploy the entire stack every time.  For example, if only the backend changes,
you only need to apply the changes for 600_backend for the specific environment you are working in
i.e. 'dev'.  The environments are specifically broken into separate sub-folders so that mistakes
in the subscription IDs, the environment names, and the state file names used by the provider
can not happen.  This also helps to work around the Terraform restriction that the terraform
block regarding remote state storage does not support variable injection.

```bash
$ az login
```

```bash
$ cd terraform/layers/100_base/Env/dev
$ terraform init
$ terraform apply -auto-approve
```