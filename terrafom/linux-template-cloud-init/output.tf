output "vm_id" {
  value       = proxmox_virtual_environment_vm.debian_vm.id
  description = "The ID of the created VM."
}

output "vm_name" {
  value       = proxmox_virtual_environment_vm.debian_vm.name
  description = "The name of the created VM."
}

output "vm_ip" {
  value       = proxmox_virtual_environment_vm.debian_vm.initialization[0].ip_config[0].ipv4[0].address
  description = "The IP address assigned to the created VM."
}

output "vm_status" {
  value       = proxmox_virtual_environment_vm.debian_vm.startup
  description = "The current startup status of the VM."
}

output "vm_memory" {
  value       = proxmox_virtual_environment_vm.debian_vm.memory[0].dedicated
  description = "The amount of dedicated memory (MB) allocated to the VM."
}

output "vm_cores" {
  value       = proxmox_virtual_environment_vm.debian_vm.cpu[0].cores
  description = "The number of CPU cores allocated to the VM."
}

output "vm_sockets" {
  value       = proxmox_virtual_environment_vm.debian_vm.cpu[0].sockets
  description = "The number of CPU sockets allocated to the VM."
}

output "vm_disk_size" {
  value       = proxmox_virtual_environment_vm.debian_vm.disk[0].size
  description = "The size of the primary disk allocated to the VM (GB)."
}

output "vm_network" {
  value       = proxmox_virtual_environment_vm.debian_vm.network_device[0].bridge
  description = "The network bridge the VM is connected to."
}

output "vm_tags" {
  value       = proxmox_virtual_environment_vm.debian_vm.tags
  description = "Tags assigned to the created VM for organization."
}
