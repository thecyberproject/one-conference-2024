output "ipv4_address" {
  description = "IP Addres"
  value       = proxmox_vm_qemu.cloudinit.default_ipv4_address
}

output "vm_name" {
  description = "IP Addres"
  value       = proxmox_vm_qemu.cloudinit.name
}
