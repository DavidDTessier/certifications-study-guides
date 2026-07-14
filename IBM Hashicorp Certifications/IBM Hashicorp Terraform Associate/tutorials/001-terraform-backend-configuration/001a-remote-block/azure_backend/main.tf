terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
 
 backend "azurerm" {
    storage_account_name = "satfstatedevops20240329"
    container_name       = "tfstate"
    key                  = "vm.terraform.tfstate"
    access_key = "5Rk5uKo8Wy7XjvK0rDvAHHAtxRoij6p7U2ZH5BzoF3vadaUayow5INMF81mONeDwtC1O3bYAJjpX+ASta4Ukeg=="
  }
}

provider "azurerm" {
  # Configuration options
  features {
    resource_group {
       prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "my_rg" {
    name = "tf_azure_providers_rg"
    location = "East US"
}


module "linuxservers" {
  source              = "Azure/compute/azurerm"
  version             = "5.3.0"
  resource_group_name = azurerm_resource_group.my_rg.name
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["mysimpleip"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]
  vm_size             = "Standard_B1ls"
  enable_ssh_key = false
  admin_password = "test123%$^!"
  depends_on = [azurerm_resource_group.my_rg]
}


module "network" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.my_rg.name
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]
  use_for_each = true
  vnet_location = azurerm_resource_group.my_rg.location

  depends_on = [azurerm_resource_group.my_rg]
}

output "linux_vm_public_name" {
  value = module.linuxservers.public_ip_dns_name
}

    