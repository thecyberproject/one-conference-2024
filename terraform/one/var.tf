variable "pm_api_url" {
  type        = string
  description = "The URL of the Proxmox host's API endpoint"
  default     = "https://134.221.49.253:8006/api2/json"
}

variable "pm_api_token_id" {
  type        = string
  description = "The ID of the PM API token, should look something like this: proxmox@pve!Dde2adJBLeD94adfU96adfeyHdSq"

}

variable "pm_api_token_secret" {
  type        = string
  description = "The secret value of the PM API token, should look something like this:  pm_api_token_secret = 78adb4c4-65568-42312e-b233-3eadfadf9"
}

variable "pm_tls_insecure" {
  type        = bool
  description = "Whether to allow insecure TLS connections for the PM API"
  default     = true
}

variable "stackstate_license_key" {
  type        = string
  description = "License key for the stackstate server"
  sensitive   = true
}

variable "stackstate_username" {
  type        = string
  description = "Username for the stackstate server"
  sensitive   = true
}

variable "stackstate_password" {
  type        = string
  description = "Password for the stackstate server"
  sensitive   = true
}

variable "proxmox_node" {
  type        = string
  description = "The promox host to deploy on"
  default     = "csthv04"
}

