// vSphere Connection Settings
vsphere_endpoint         = "10.10.10.100"
vsphere_username         = "administrator@vsphere.local"
vsphere_password         = "osu@tCuJe9bE7fv!"
vsphere_insecure_connection = true

// vSphere Infrastructure Settings
vsphere_datacenter    = "homelab"
vsphere_cluster       = "cluster"
vsphere_host          = "esx2.dragon.local"
vsphere_datastore     = "esxi2-datastore1"
vsphere_folder        = "Templates"
vsphere_resource_pool = "Resources"
vsphere_network       = "VLAN-20"

// Common Settings
common_data_source       = "http"
common_http_ip           = null
common_http_port_min     = 8000
common_http_port_max     = 8099
common_ip_wait_timeout   = "20m"
common_ip_settle_timeout = "5s"
common_shutdown_timeout  = "15m"
common_vm_version        = 15
common_tools_upgrade_policy = true
common_remove_cdrom      = true

// VM Configuration
vm_name             = "template-debian-12"
iso_file            = "[esxi2-datastore1] iso/linux/debian/debian-12.11.0-amd64-netinst.iso"
memory              = "1024"
cores               = "2"
disk_size           = "20480"

// VM Guest OS Settings
vm_guest_os_type      = "debian10_64Guest"
vm_guest_os_name      = "debian"
vm_guest_os_version   = "12.11"
