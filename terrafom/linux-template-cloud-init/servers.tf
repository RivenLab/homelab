resource "proxmox_virtual_environment_vm" "debian_vm" {
  name        = var.vm_name
  description = var.vm_description
  tags        = var.vm_tags

  node_name = var.node_name

  agent {
    enabled = var.agent_enabled
  }

  clone {
    full         = var.clone_full
    node_name    = var.clone_node_name
    vm_id        = var.clone_vm_id
    datastore_id = var.clone_datastore_id
  }

  cpu {
    cores   = var.cpu_cores
    sockets = var.cpu_sockets
    type    = var.cpu_type
  }

  memory {
    dedicated = var.memory_dedicated
  }

  disk {
    size         = var.disk_size
    interface    = var.disk_interface
    iothread     = var.disk_iothread
    discard      = var.disk_discard
    datastore_id = var.datastore_id
  }

  network_device {
    bridge      = var.network_bridge
    model       = var.network_model
    firewall    = var.network_firewall
    vlan_id     = var.network_vlan_id
  }

  initialization {
    datastore_id = var.clone_datastore_id
    dns {
      domain  = var.dns_domain
      servers = var.dns_servers
    }
    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }
    user_account {
      username = var.username
      password = var.password
      keys     = var.ssh_keys
    }
  }

  operating_system {
    type = var.os_type
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "dragon"
      private_key = "${file("~/.ssh/id_ed25519")}"
      host     = split("/", var.ip_address)[0]
  }
    inline = [
      "sleep 2",
      "ROOT_DISK=$(lsblk -no PKNAME,MOUNTPOINT | grep '/$' | awk '{print $1}' | sed 's/[0-9]*$//')",
      "par=$()",
      "sudo growpart /dev/$ROOT_DISK 2",
      "sudo growpart /dev/$ROOT_DISK 5",
      "sudo pvresize /dev/$${ROOT_DISK}5",
      "LV_PATH=$(findmnt / -no SOURCE)",
      "sudo lvextend -l +100%FREE $LV_PATH",
      "sudo resize2fs $LV_PATH"
    ]
  }
}
