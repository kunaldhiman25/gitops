variable "prefix" {
  default = "tfvmex"
}

# ----------------- Resource Group -----------------

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# ----------------- Resource Lock on the Resource Group -----------------

resource "azurerm_management_lock" "resource-group-level" {
  name       = "resource-group-level-lock"
  scope      = azurerm_resource_group.resource_group.id
  lock_level = "ReadOnly"
  notes      = "This Resource Group is Read-Only"
}

# ----------------- Virtual Machine -----------------

resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm-name
  location              = azurerm_resource_group.resource_group.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.network-interface.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}