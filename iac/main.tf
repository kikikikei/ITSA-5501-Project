terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "43fa4de2-4989-4986-b4bc-843878768d96"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "resource_group_name_devops"
  location = "Canada Central"
  tags     = { Environment = "Dev" }
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "myVMVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = { Environment = "Dev" }
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "myVMSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP
resource "azurerm_public_ip" "pip" {
  name                = "myVMPublicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method   = "Static"    
  sku                 = "Standard"

  tags = {
    Environment = "Dev"
  }
}


# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "myVMNic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = { Environment = "Dev" }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "myLinuxVM"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B1s"

  admin_username                  = var.admin_username
  network_interface_ids           = [azurerm_network_interface.nic.id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("C:/Users/grace/.ssh/id_rsa.pub")

  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = { Environment = "Dev" }
}
