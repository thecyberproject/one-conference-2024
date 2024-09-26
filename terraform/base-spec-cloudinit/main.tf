locals {

  proxmox_node          = var.proxmox_node
  proxmox_resource_pool = var.proxmox_resource_pool

  vm_name          = var.vm_name
  vm_id            = var.vm_id != null ? var.vm_id : 0
  vm_description   = var.vm_description
  vm_start_on_boot = var.vm_start_on_boot
  vm_boot_order    = var.vm_boot_order != null ? var.vm_boot_order : ""

  template_clone      = var.template_clone
  template_full_clone = var.template_full_clone


  admin_username = var.admin_username
  admin_password = var.admin_password

  admin_public_ssh_keys = var.ssh_empty == true ? [] : split("\n", data.local_file.ssh_keys.content)


  sockets = var.sockets
  cores   = var.cores
  memory  = var.memory

  networks = var.networks

  primary_network_model  = var.primary_network_model
  primary_network_bridge = var.primary_network_bridge


  disks                     = var.disks
  disk_default_type         = var.disk_default_type
  disk_default_format       = var.disk_default_format
  disk_default_storage_pool = var.disk_default_storage_pool
  disk_default_size         = var.disk_default_size
  backup_enabled            = var.backup_enabled

  ipconfig0_elements = [
    var.primary_network_cidr_address != null ? "ip=${var.primary_network_cidr_address}" : "ip=dhcp",
    var.primary_network_gateway != null ? "gw=${var.primary_network_gateway}" : ""
  ]

  ipconfig1_elements = var.ipconfig1_elements
  ipconfig2_elements = var.ipconfig2_elements
  ipconfig3_elements = var.ipconfig3_elements

  # ipconfig1 = var.ipconfig1

  ciuser     = var.admin_username
  cipassword = var.admin_password
  cistorage  = var.default_ci_cdrom_storage
  cicustom   = var.cicustom
  tags       = var.tags
}

resource "proxmox_vm_qemu" "cloudinit" {
  name    = local.vm_name
  desc    = local.vm_description
  vmid    = local.vm_id
  os_type = "cloud-init"
  agent   = 1
  onboot  = local.vm_start_on_boot
  boot    = local.vm_boot_order

  target_node = local.proxmox_node
  pool        = local.proxmox_resource_pool

  clone      = local.template_clone
  full_clone = local.template_full_clone

  cores   = local.cores
  sockets = local.sockets
  memory  = local.memory


  dynamic "disks" {
    for_each = local.disks[*]
    iterator = item
    content {
      virtio {
        dynamic "virtio0" {
          for_each = item.value.virtio0[*]
          iterator = i
          content {
            disk {
              storage = lookup(i.value, "storage", local.disk_default_storage_pool)
              size    = lookup(i.value, "size", local.disk_default_size)
              format  = lookup(i.value, "format", local.disk_default_format)
              backup  = lookup(i.value, "backup", local.backup_enabled)
            }
          }
        }
        dynamic "virtio1" {
          for_each = item.value.virtio1[*]
          iterator = i
          content {
            disk {
              storage = lookup(i.value, "storage", local.disk_default_storage_pool)
              size    = lookup(i.value, "size", local.disk_default_size)
              format  = lookup(i.value, "format", local.disk_default_format)
              backup  = lookup(i.value, "backup", local.backup_enabled)
            }
          }
        }
      }
    }
  }
  dynamic "network" {
    for_each = local.networks
    content {
      model  = lookup(network.value, "model", local.primary_network_model)
      bridge = lookup(network.value, "bridge", local.primary_network_bridge)
    }
  }

  nameserver   = var.nameserver
  searchdomain = null
  ipconfig0    = join(",", compact(local.ipconfig0_elements))
  ipconfig1    = local.ipconfig1_elements
  ipconfig2    = local.ipconfig2_elements
  ipconfig3    = local.ipconfig3_elements

  ciuser                  = local.admin_username
  cipassword              = local.admin_password
  cicustom                = local.cicustom
  cloudinit_cdrom_storage = local.cistorage
  tags                    = join(",", local.tags)


  sshkeys = <<-EOF
      %{for key in local.admin_public_ssh_keys~}
      ${key}
      %{endfor~}
      EOF

}
