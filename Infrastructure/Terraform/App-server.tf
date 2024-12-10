module "VM" {

  source = "./modules/VM"
  resource_group_name = var.resource_group_name
  resource_group_location = var.resource_group_location
  vm_name = var.vm_name
  environment = var.environment
  hostname = var.hostname
}

