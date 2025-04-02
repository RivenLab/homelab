# Proxmox API Configuration
variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API Token"
  type        = string
  sensitive   = true
}

variable "ssh_username" {
  description = "SSH username for the Proxmox server"
  type        = string
}

variable "proxmox_username" {
  description = "Username for the Proxmox server"
  type        = string
}

variable "proxmox_password" {
  description = "Password for the Proxmox server"
  type        = string
}

# VM Configuration
variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "vm_description" {
  description = "Description of the VM"
  type        = string
}

variable "vm_tags" {
  description = "Tags for the VM"
  type        = list(string)
}

variable "node_name" {
  description = "Node name for the VM"
  type        = string
}

variable "datastore_id" {
  description = "Datastore ID for the VM"
  type        = string
}

# Clone Configuration
variable "clone_full" {
  description = "Whether to perform a full clone"
  type        = bool
}

variable "clone_node_name" {
  description = "Node name for the clone operation"
  type        = string
}

variable "clone_vm_id" {
  description = "ID of the VM to clone"
  type        = number
}

variable "clone_datastore_id" {
  description = "Datastore ID for the clone"
  type        = string
}

# CPU Configuration
variable "cpu_cores" {
  description = "Number of CPU cores for the VM"
  type        = number
}

variable "cpu_sockets" {
  description = "Number of CPU sockets for the VM"
  type        = number
}

variable "cpu_type" {
  description = "CPU type for the VM"
  type        = string
}

# Memory Configuration
variable "memory_dedicated" {
  description = "Dedicated memory for the VM (MB)"
  type        = number
}

# Disk Configuration
variable "disk_size" {
  description = "Size of the disk for the VM (GB)"
  type        = number
}

variable "disk_interface" {
  description = "Disk interface type for the VM"
  type        = string
}

variable "disk_iothread" {
  description = "Enable I/O threads for the disk"
  type        = bool
}

# Network Device Configuration
variable "network_bridge" {
  description = "Network bridge for the VM"
  type        = string
}

variable "network_model" {
  description = "Network model for the VM"
  type        = string
}

variable "network_firewall" {
  description = "Enable or disable firewall for the network device"
  type        = bool
}

variable "network_vlan_id" {
  description = "VLAN ID for the network device"
  type        = number
}

# Operating System Configuration
variable "os_type" {
  description = "Operating system type for the VM"
  type        = string
}

# Networking Configuration
variable "ip_address" {
  description = "IP address of the VM"
  type        = string
}

variable "gateway" {
  description = "Gateway for the VM"
  type        = string
}

variable "dns_servers" {
  description = "DNS servers for the VM"
  type        = list(string)
}

# User Account Configuration
variable "username" {
  description = "Username for the VM"
  type        = string
}

variable "password" {
  description = "Password for the VM"
  type        = string
  sensitive   = true
}

# SSH Keys
variable "ssh_keys" {
  description = "SSH keys for the VM"
  type        = list(string)
}

# QEMU Guest Agent
variable "agent_enabled" {
  description = "Whether to enable the QEMU guest agent"
  type        = bool
}

# DNS Configuration
variable "dns_domain" {
  description = "The DNS domain for the VM"
  type        = string
}
