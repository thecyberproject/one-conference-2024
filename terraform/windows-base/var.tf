

# ---------------------------------------------------------------------------------------------------------------------
# Proxmox server settings
# These are used to discover unmanaged resources used during deployment.
# ---------------------------------------------------------------------------------------------------------------------


# variable "pm_api_url" {
#   type        = string
#   description = "The URL of the Proxmox host's API endpoint"
#   default     = "https://127.0.0.1:8006/api2/json"
# }

# variable "pm_api_token_id" {
#   type        = string
#   description = "The ID of the PM API token, should look something like this: proxmox@pve!Dde2adJBLeD94adfU96adfeyHdSq"

# }

# variable "pm_api_token_secret" {
#   type        = string
#   description = "The secret value of the PM API token, should look something like this:  pm_api_token_secret = 78adb4c4-65568-42312e-b233-3eadfadf9"
# }

# variable "pm_tls_insecure" {
#   type        = bool
#   description = "Whether to allow insecure TLS connections for the PM API"
#   default     = true
# }

variable "proxmox_node" {
  type        = string
  description = "Which node in the Proxmox cluster to start the virtual machine on during creation."
  default     = "host"
}
variable "ssh_empty" {
  type        = bool
  description = "bool for disabling default sshkeys -> required when using cloud_init_file"
  default     = true
}
variable "proxmox_resource_pool" {
  type        = string
  description = "Name of resource pool to create virtual machine in."
  default     = null
}

# ---------------------------------------------------------------------------------------------------------------------
# Template settings
# These are used to discover unmanaged resources used during deployment.
# ---------------------------------------------------------------------------------------------------------------------

variable "vm_name" {
  type        = string
  description = "Name of VM"
}

variable "admin_username" {
  type        = string
  description = "set a custom name"
  default     = null
}
variable "admin_password" {
  type        = string
  description = "set a custom name"
  default     = null
}


variable "cicustom" {
  description = "Instead specifying ciuser, cipasword, etc... you can specify the path to a custom cloud-init config file here. Grants more flexibility in configuring cloud-init"
  type        = string
  default     = null
}

variable "vm_description" {
  type        = string
  description = "Description of VM"
  default     = "This VM is a clone of a default template"
}

variable "vm_id" {
  type        = number
  description = "assign a VM id that is not used"
}

variable "template_full_clone" {
  type        = string
  description = "Name of the Proxmox template to clone from."
  default     = null
}

variable "template_clone" {
  type        = string
  description = "Whether to allow insecure TLS connections for the PM API"
  default     = "ubuntu-cloud-init-template"
}

variable "vm_start_on_boot" {
  type        = bool
  description = "Specifies whether a VM will be started during system bootup."
  default     = false
}

variable "vm_boot_order" {
  type        = string
  description = "The boot order for the VM. Proxmox 6.2 changed boot order text from 'cdn'."
  default     = ""
}


variable "sockets" {
  type        = number
  description = "Number of Cores"
  default     = 1
}

variable "cores" {
  type        = number
  description = "Number of Cores"
  default     = 4
}
variable "memory" {
  type        = number
  description = "Memory (RAM)"
  default     = 4096
}

variable "storage_location" {
  type        = string
  description = "proxmox storage location"
  default     = "encrypt"
}

variable "storage_type" {
  type        = string
  description = "storage type"
  default     = "virtio"
}

variable "disks" {
  type        = list(any)
  description = "A list of disks to attach to the VM. "
  default     = []
}

variable "disk_default_format" {
  type        = string
  description = "The format of the file backing the disk."
  default     = "raw"

  validation {
    condition     = contains(["raw", "cow", "qcow", "qed", "qcow2", "vmdk", "cloop"], var.disk_default_format)
    error_message = "The Proxmox disk format is invalid."
  }
}

variable "disk_default_type" {
  type        = string
  description = "The type of disk. Can be scsi, sata, virtio or ide"
  default     = "virtio"

  validation {
    condition     = contains(["scsi", "sata", "virtio", "ide"], var.disk_default_type)
    error_message = "The Proxmox disk type is invalid."
  }
}


variable "disk_default_storage_pool" {
  type        = string
  description = "Name of the Proxmox storage pool to store the virtual machine disk on."
  default     = "local-zfs"
}

variable "disk_default_size" {
  type        = string
  description = "The size of the disk, including a unit suffix, such as 10G to indicate 10 gigabytes."
  default     = null
}

variable "backup_enabled" {
  type        = bool
  description = "Backup setting default is false"
  default     = false
}

# ---------------------------------------------------------------------------------------------------------------------
# Netwerk settings
# 
# ---------------------------------------------------------------------------------------------------------------------
variable "nameserver" {
  type        = string
  description = "Nameserver"
  default     = "1.1.1.1"
}
variable "network_model_type" {
  type        = string
  description = "Network Model Type"
  default     = "virtio"
}

variable "primary_network_model" {
  type        = string
  description = "Model of the virtual network adapter."
  default     = "virtio"

  validation {
    condition     = contains(["rtl8139", "ne2k_pci", "e1000", "pcnet", "virtio", "ne2k_isa", "i82551", "i82557b", "i82559er", "vmxnet3", "e1000-82540em", "e1000-82544gc", "e1000-82545em"], var.primary_network_model)
    error_message = "The Proxmox network model is invalid."
  }
}

variable "primary_network_bridge" {
  type        = string
  description = "Which Proxmox bridge to attach the adapter to."
  default     = "vmbr0"
}

variable "primary_network_cidr_address" {
  type        = string
  description = "The IP address with CIDR block for the primary network interface. DHCP will be used if not set."
  default     = null
}

variable "primary_network_gateway" {
  type        = string
  description = "The network gateway to use for the primary network interface."
  default     = null
}

variable "network_bridge" {
  type        = string
  description = "proxmox bridge settings e.g.: vmbr0"
  default     = "vmbr0"
}

variable "tags" {
  type        = list(string)
  description = "List of virtual machine tags."
  default     = []
}
