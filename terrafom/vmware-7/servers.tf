# Data sources for vSphere infrastructure
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_virtual_machine_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Main VM resource
resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder

  num_cpus = var.cpu_cores * var.cpu_sockets
  memory   = var.memory_mb
  guest_id = var.guest_id

  scsi_type = var.scsi_type

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = var.disk_size
    thin_provisioned = var.disk_thin_provisioned
    eagerly_scrub    = var.disk_eagerly_scrub
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  extra_config = {
    "guestinfo.metadata"          = base64encode(templatefile("${path.module}/metadata-${var.network_config_type}.yml", {
      hostname = var.hostname
      ip_address = var.ip_address
      ip_netmask = var.ip_netmask
      gateway = var.gateway
      dns_servers = var.dns_servers
      dns_domain = var.dns_domain
    }))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(templatefile("${path.module}/userdata.yml", {
      username = var.username
      password = var.password
      ssh_keys = var.ssh_keys
    }))
    "guestinfo.userdata.encoding" = "base64"
  }

  # Tags
  tags = var.vm_tags

  # Annotation
  annotation = var.vm_description
}
