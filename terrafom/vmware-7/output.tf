output "vm_id" {
  description = "The ID of the created VM"
  value       = vsphere_virtual_machine.vm.id
}

output "vm_moid" {
  description = "The managed object ID of the VM"
  value       = vsphere_virtual_machine.vm.moid
}

output "vm_uuid" {
  description = "The UUID of the VM"
  value       = vsphere_virtual_machine.vm.uuid
}

output "vm_name" {
  description = "The name of the VM"
  value       = vsphere_virtual_machine.vm.name
}

output "vm_guest_ip_addresses" {
  description = "The IP addresses of the VM"
  value       = vsphere_virtual_machine.vm.guest_ip_addresses
}

output "vm_default_ip_address" {
  description = "The default IP address of the VM"
  value       = vsphere_virtual_machine.vm.default_ip_address
}

