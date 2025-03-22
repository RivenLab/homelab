source "proxmox-iso" "debian" {
  proxmox_url              = "https://${var.proxmox_host}/api2/json"
  insecure_skip_tls_verify = true
  username                 = var.proxmox_api_user
  #token                    = var.proxmox_api_password
  password                 = var.proxmox_password

  template_description = "Built from ${basename(var.iso_file)} on ${formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())}"
  node                 = var.proxmox_node
  ssh_timeout          = "25m"

  boot_iso {
    type         = "scsi"
    iso_file     = var.iso_file
    unmount      = true
    iso_checksum = var.iso_checksum
  }

  network_adapters {
    bridge   = "vmbr0"
    firewall = false
    model    = "virtio"
    vlan_tag = var.network_vlan
  }

  disks {
    disk_size    = var.disk_size
    format       = var.disk_format
    io_thread    = true
    storage_pool = var.disk_storage_pool
    type         = "scsi"
  }

  scsi_controller = "virtio-scsi-single"
  http_directory = "./"
  boot_command   = ["<esc><wait>auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
  boot_wait      = "10s"

  cloud_init              = true
  cloud_init_storage_pool = var.cloudinit_storage_pool

  vm_name  = var.vm_name
  vm_id    = var.vm_id
  cpu_type = var.cpu_type
  os       = "l26"
  memory   = var.memory
  cores    = var.cores
  sockets  = "1"
  machine  = var.machine_type

  ssh_username = "root"
  ssh_password = "packer"
}

build {
  sources = ["source.proxmox-iso.debian"]

  provisioner "file" {
    destination = "/etc/cloud/cloud.cfg"
    source      = "cloud.cfg"
  }
}