
locals {
  instance_suffix = format("%03d", var.instance_number)  # This will always create a 3-digit number with leading zeros
  
  company_prefix = var.company_code != "" ? lower(var.company_code) : ""
  
  vnet_name      = var.company_code != "" ? "vnet-${local.company_prefix}-hyperv-${local.location_map[var.location]}-${local.instance_suffix}" : "vnet-hyperv-${local.location_map[var.location]}-${local.instance_suffix}"
  appName        = "hyperv"
  # address_spaces = ["172.100.0.0/17"]
  location_map   = jsondecode(file("${path.module}/configs/geo_codes.tf.json")).locals.builtin_azure_backup_geo_codes               
  vmname         = var.company_code != "" ? "${local.company_prefix}${var.vmname}${local.location_map[var.location]}${local.instance_suffix}" : "${var.vmname}${local.location_map[var.location]}${local.instance_suffix}"
  rgname         = var.company_code != "" ? "rg-${local.company_prefix}-${local.appName}-${local.location_map[var.location]}-${local.instance_suffix}" : "rg-${local.appName}-${local.location_map[var.location]}-${local.instance_suffix}"
  subnets = [
    { name = "nat", address_prefix = "172.100.0.0/24", nsg_name = "nat-nsg", private_ip = "172.100.0.4" },
    { name = "hypervlan", address_prefix = "172.100.1.0/24", nsg_name = "hyperv-nsg", private_ip = "172.100.1.4" },
    { name = "ghosted", address_prefix = "172.100.2.0/24", nsg_name = "ghosted-nsg", private_ip = "" },
    { name = "azurevms", address_prefix = "172.100.3.0/24", nsg_name = "azurevms-nsg", private_ip = "" }
  ]

ghosted_subnet_address_prefix = local.subnets[2].address_prefix

  nsg_rules = {
    "nat-nsg" = [
      {
        name                       = "RDP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "172.100.0.4"
      }
    ]
    "hyperv-nsg" = [
      {
        name                       = "RDP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "172.100.1.4"
      }
    ]
    "ghosted-nsg" = []
    "azurevms-nsg" = []
  }

  # DSCInstallWindowsFeaturesUri = "${var._artifactsLocation}dscinstallwindowsfeatures.zip${var._artifactsLocationSasToken}"
  # HVHostSetupScriptUri    = "${var._artifactsLocation}hvhostsetup.ps1${var._artifactsLocationSasToken}"

  DSCInstallWindowsFeaturesUri = "${var.artifacts_location}scripts/dscinstallwindowsfeatures.zip"
  HVHostSetupScriptUri         = "${var.artifacts_location}scripts/hvhostsetup.ps1"

}