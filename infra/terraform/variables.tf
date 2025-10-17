variable "company_code" {
  description = "Three-letter company code/abbreviation. If not provided, will be empty."
  type        = string
  default     = ""
  
  validation {
    condition     = var.company_code == "" || (length(var.company_code) == 3 && can(regex("^[a-zA-Z]+$", var.company_code)))
    error_message = "Company code must be either empty or exactly 3 alphabetic characters."
  }
}

variable "instance_number" {
  description = "Instance number for resource naming (1-999)"
  type        = number
  default     = 1

  validation {
    condition     = var.instance_number > 0 && var.instance_number < 1000
    error_message = "Instance number must be between 1 and 999."
  }
}

variable "artifacts_location" {
  description = "The base URI where artifacts required by this template are located including a trailing '/'"
  default     = "https://raw.githubusercontent.com/crgarcia12/azure-migrate-env/main/"
}

# variable "_artifactsLocationSasToken" {
#   description = "The sasToken required to access _artifactsLocation. When the template is deployed using the accompanying scripts, a sasToken will be automatically generated. Use the defaultValue if the staging location is not secured."
#   default     = ""
# }

variable "location" {
  description = "Location for all resources."
  default     = "swedencentral"
}

variable "hostvmsize" {
  description = "Size of the Host Virtual Machine"
  default     = "Standard_D4s_v3"
  validation {
    condition     = contains(["Standard_D2_v3", "Standard_D4_v3", "Standard_D8_v3", "Standard_D16_v3", "Standard_D32_v3", "Standard_D2s_v3", "Standard_D4s_v3", "Standard_D8s_v3", "Standard_D16s_v3", "Standard_D32s_v3", "Standard_D64_v3", "Standard_E2_v3", "Standard_E4_v3", "Standard_E8_v3", "Standard_E16_v3", "Standard_E32_v3", "Standard_E64_v3", "Standard_D64s_v3", "Standard_E2s_v3", "Standard_E4s_v3", "Standard_E8s_v3", "Standard_E16s_v3", "Standard_E32s_v3", "Standard_E64s_v3"], var.hostvmsize)
    error_message = "Invalid VM size selected"
  }
}

variable "vmpassword" {
  type      = string
  sensitive = true
}