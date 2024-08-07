output "ad_address" {
  description = "IP Addres for the created vm"
  value       = module.ad[*].ipv4_address
}

output "ad_name" {
  description = "Name for the created vm"
  value       = module.ad[*].vm_name
}

output "server_name" {
  description = "Name for the created vm"
  value       = module.server[*].vm_name
}

output "server_address" {
  description = "IP Addres for the created vm"
  value       = module.server[*].ipv4_address
}

output "client_name" {
  description = "Name for the created vm"
  value       = [module.client[*].vm_name, ]
}

output "client_address" {
  description = "IP Addres for the created vm"
  value       = module.client[*].ipv4_address
}