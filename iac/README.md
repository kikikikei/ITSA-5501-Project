## Terraform / Azure 

Variables

resource_group_name = "pm3VMResourceGroup"

location = "eastus"

vm_size = "Standard_B1s"

admin_username = "azureuser"

Resources Created

Resource Group

Virtual Network (10.0.0.0/16)

Subnet (10.0.1.0/24)

Public IP

Network Interface

Linux VM (myLinuxVM)

OS: Ubuntu Server 18.04 LTS

SSH public key authentication

Outputs

resource_group_id

vm_public_ip

vm_id