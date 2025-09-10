# vSphere Authentication
variable "vsphere_user" {
  description = "vSphere username"
  type        = string
  default     = "administrator@vsphere.local"
}

variable "vsphere_password" {
  description = "vSphere password"
  type        = string
  sensitive   = true
}

variable "vsphere_server" {
  description = "vSphere server address"
  type        = string
}

# vSphere Infrastructure
variable "vsphere_datacenter" {
  description = "vSphere datacenter name"
  type        = string
}

variable "vsphere_datastore" {
  description = "vSphere datastore name"
  type        = string
}

variable "vsphere_compute_cluster" {
  description = "vSphere compute cluster name"
  type        = string
}

variable "vsphere_network" {
  description = "vSphere network name"
  type        = string
}

variable "vsphere_virtual_machine_template" {
  description = "vSphere VM template name to clone from"
  type        = string
}

# VM Configuration
variable "vm_name" {
  description = "Name of the VM to be created"
  type        = string
}

variable "vm_description" {
  description = "Description of the VM"
  type        = string
  default     = ""
}

variable "vm_folder" {
  description = "Folder path for the VM (relative to datacenter)"
  type        = string
  default     = ""
}

variable "vm_tags" {
  description = "Tags for the VM"
  type        = list(string)
  default     = []
}

# CPU Configuration
variable "cpu_cores" {
  description = "Number of CPU cores for the VM"
  type        = number
  default     = 2
}

variable "cpu_sockets" {
  description = "Number of CPU sockets for the VM"
  type        = number
  default     = 1
}

# Memory Configuration
variable "memory_mb" {
  description = "Memory for the VM in MB"
  type        = number
  default     = 4096
}

# Disk Configuration
variable "disk_size" {
  description = "Size of the disk for the VM"
  type        = number
  default     = 20
}

variable "disk_thin_provisioned" {
  description = "Whether to thin provision the disk"
  type        = bool
  default     = true
}

variable "disk_eagerly_scrub" {
  description = "Whether to eagerly scrub the disk"
  type        = bool
  default     = false
}

# Network Configuration
variable "ip_address" {
  description = "IP address for the VM"
  type        = string
}

variable "ip_netmask" {
  description = "IP netmask (e.g., 24 for /24)"
  type        = number
  default     = 24
}

variable "gateway" {
  description = "Gateway for the VM"
  type        = string
}

variable "dns_servers" {
  description = "DNS servers for the VM"
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "dns_domain" {
  description = "DNS domain for the VM"
  type        = string
  default     = "local"
}

# VM Customization
variable "hostname" {
  description = "Hostname for the VM"
  type        = string
}

variable "username" {
  description = "Username for the VM"
  type        = string
}

variable "password" {
  description = "Password for the VM"
  type        = string
  sensitive   = true
}

variable "ssh_keys" {
  description = "SSH keys for the VM"
  type        = list(string)
  default     = []
}

# Guest OS Configuration
variable "guest_id" {
  description = "Guest OS ID (e.g., ubuntu64Guest, debian11_64Guest)"
  type        = string
  default     = "debian11_64Guest"
}

variable "scsi_type" {
  description = "SCSI controller type"
  type        = string
  default     = "pvscsi"
}

variable "network_config_type" {
  description = "Network configuration type: 'ifupdown' for Debian or 'netplan' for Ubuntu"
  type        = string
  default     = "ifupdown"
  validation {
    condition     = contains(["ifupdown", "netplan"], var.network_config_type)
    error_message = "Network config type must be 'ifupdown' or 'netplan'."
  }
}
