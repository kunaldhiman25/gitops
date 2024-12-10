resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.vm_name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.vm_name}-subnet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "network_interface" {
  name                = "${var.vm_name}-network_interface"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "${var.vm_name}-IP"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}
resource "azurerm_public_ip" "publicip" {
  name                = "publicip"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"
}

provider "local" {}

resource "local_file" "terraform_output" {
  content  = jsonencode({
    public_ip = azurerm_public_ip.publicip.ip_address
  })
  filename = "./terraform_output.json"
}