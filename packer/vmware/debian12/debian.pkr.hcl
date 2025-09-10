source "vsphere-iso" "debian" {
  // vCenter Server Endpoint Settings and Credentials
  vcenter_server      = var.vsphere_endpoint
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure_connection

  // vSphere Settings
  datacenter    = var.vsphere_datacenter
  cluster       = var.vsphere_cluster
  host          = var.vsphere_host
  datastore     = var.vsphere_datastore
  folder        = var.vsphere_folder
  resource_pool = var.vsphere_resource_pool

  // Virtual Machine Settings
  vm_name              = var.vm_name
  guest_os_type        = var.vm_guest_os_type
  firmware             = var.vm_firmware
  CPUs                 = var.cores
  RAM                  = var.memory
  cdrom_type           = "sata"
  disk_controller_type = [var.vm_disk_controller_type]
  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = var.vsphere_network
    network_card = var.vm_network_card
  }
  vm_version           = var.common_vm_version
  remove_cdrom         = var.common_remove_cdrom
  tools_upgrade_policy = var.common_tools_upgrade_policy

  // Removable Media Settings
  iso_paths = [var.iso_file]

  // HTTP Content for Preseed
  http_content = {
    "/preseed.cfg" = file("preseed.cfg")
  }

  // Boot and Provisioning Settings
  http_ip       = var.common_http_ip
  http_port_min = var.common_http_port_min
  http_port_max = var.common_http_port_max
  boot_order    = var.vm_boot_order
  boot_wait     = var.vm_boot_wait
  boot_command = [
    "<esc><wait>auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"
  ]
  ip_wait_timeout   = var.common_ip_wait_timeout
  ip_settle_timeout = var.common_ip_settle_timeout
  shutdown_command  = "echo '${var.build_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout  = var.common_shutdown_timeout

  // Communicator Settings and Credentials
  communicator   = "ssh"
  ssh_username   = var.build_username
  ssh_password   = var.build_password
  ssh_port       = var.communicator_port
  ssh_timeout    = var.communicator_timeout

  // Template Settings
  convert_to_template = true
}

build {
  sources = ["source.vsphere-iso.debian"]

  provisioner "file" {
    destination = "/etc/cloud/cloud.cfg"
    source      = "cloud.cfg"
  }

  provisioner "shell" {
    inline = [
      "cloud-init clean --machine-id",
    ]
  }
}