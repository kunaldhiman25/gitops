variable "prefix" {
  default = "tfvmex"
}

# ----------------- Resource Group -----------------

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location

  tags = {
    environment = var.environment
  }
}

# ----------------- Resource Lock on the Resource Group -----------------
/*
resource "azurerm_management_lock" "resource-group-level" {
  name       = "resource-group-level-lock"
  scope      = azurerm_resource_group.resource_group.id
  lock_level = "ReadOnly"
  notes      = "This Resource Group is Read-Only"
}
*/
# ----------------- Virtual Machine -----------------

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/azurekey.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}