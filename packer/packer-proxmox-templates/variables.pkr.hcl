variable "iso_file" {
  type = string
}

variable "iso_checksum" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_id" {
  type = string
}

variable "cloudinit_storage_pool" {
  type    = string
}

variable "cores" {
  type    = string
}

variable "disk_format" {
  type    = string
}

variable "disk_size" {
  type    = string
}

variable "disk_storage_pool" {
  type    = string
}

variable "cpu_type" {
  type    = string
}

variable "memory" {
  type    = string
}

variable "network_vlan" {
  type    = string
}

variable "machine_type" {
  type    = string
}

variable "proxmox_api_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "proxmox_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "proxmox_api_user" {
  type = string
}

variable "proxmox_host" {
  type = string
}

variable "proxmox_node" {
  type = string
}