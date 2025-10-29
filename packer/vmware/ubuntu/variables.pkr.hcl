variable "iso_file" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "cores" {
  type    = string
}

variable "disk_size" {
  type    = string
}

variable "memory" {
  type    = string
}

// vSphere Connection Settings
variable "vsphere_endpoint" {
  type = string
}

variable "vsphere_username" {
  type = string
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}

variable "vsphere_insecure_connection" {
  type    = bool
  default = true
}

// vSphere Infrastructure Settings
variable "vsphere_datacenter" {
  type = string
}

variable "vsphere_cluster" {
  type = string
}

variable "vsphere_host" {
  type = string
}

variable "vsphere_datastore" {
  type = string
}

variable "vsphere_folder" {
  type = string
}

variable "vsphere_resource_pool" {
  type = string
}

variable "vsphere_network" {
  type = string
}

// VM Settings
variable "vm_guest_os_type" {
  type    = string
  default = "debian10_64Guest"
}

variable "vm_guest_os_name" {
  type    = string
  default = "debian"
}

variable "vm_guest_os_version" {
  type    = string
  default = "12.11"
}

variable "vm_firmware" {
  type    = string
  default = "bios"
}

variable "vm_disk_controller_type" {
  type    = string
  default = "lsilogic-sas"
}

variable "vm_network_card" {
  type    = string
  default = "vmxnet3"
}

variable "vm_boot_order" {
  type    = string
  default = "disk,cdrom"
}

variable "vm_boot_wait" {
  type    = string
  default = "10s"
}

// Build Settings
variable "build_username" {
  type    = string
  default = "root"
}

variable "build_password" {
  type    = string
  default = "packer"
}

variable "communicator_port" {
  type    = string
  default = "22"
}

variable "communicator_timeout" {
  type    = string
  default = "25m"
}

// Common Settings
variable "common_data_source" {
  type    = string
  default = "http"
}

variable "common_http_ip" {
  type    = string
  default = null
}

variable "common_http_port_min" {
  type    = string
  default = "8000"
}

variable "common_http_port_max" {
  type    = string
  default = "8099"
}

variable "common_ip_wait_timeout" {
  type    = string
  default = "20m"
}

variable "common_ip_settle_timeout" {
  type    = string
  default = "5s"
}

variable "common_shutdown_timeout" {
  type    = string
  default = "15m"
}

variable "common_vm_version" {
  type    = string
  default = "15"
}

variable "common_tools_upgrade_policy" {
  type    = bool
  default = true
}

variable "common_remove_cdrom" {
  type    = bool
  default = true
}

// vSphere Guest OS Customization Settings
variable "vm_guest_os_customization" {
  type    = bool
  default = true
  description = "Enable vSphere Guest OS Customization"
}

variable "vm_guest_os_customization_spec" {
  type = object({
    identity = object({
      linux_prep = object({
        host_name = string
        domain    = string
      })
    })
    global_ip_settings = object({
      dns_suffix_list = list(string)
      dns_server_list = list(string)
    })
  })
  default = null
  description = "Guest OS Customization specification"
}