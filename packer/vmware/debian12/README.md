# Packer vSphere Templates Installation Guide

## Prerequisites

- **VMware vSphere**: Version 6.7 or higher
- **Packer**: Version 1.12.0 or higher
- **ISO**: ISO file of Debian 11 or Debian 12

## Installation Steps

### **Clone the Repository**
   ```bash
   git clone https://github.com/RivenLab/packer-vsphere-templates.git
   ```
### **Navigate to the Directory**
   ```bash
    cd packer-vsphere-templates
   ```
### **Copy Example Variables**
   ```bash
   cp example-variables.pkrvars.hcl variables.auto.pkrvars.hcl
   ```
### **Edit Variables**

Open `variables.auto.pkrvars.hcl` and update it to correspond with your vSphere environment:

- `vsphere_endpoint`: Your vCenter server IP address
- `vsphere_username`: vCenter username (usually "administrator@vsphere.local")
- `vsphere_password`: vCenter password
- `vsphere_datacenter`: Your datacenter name
- `vsphere_cluster`: Your cluster name
- `vsphere_host`: Target ESXi host IP
- `vsphere_datastore`: Target datastore name
- `vsphere_folder`: Folder name for templates
- `vsphere_resource_pool`: Resource pool name
- `vsphere_network`: Network name
- `iso_file`: Path to ISO file on datastore (format: `[datastore] path/to/iso`)

### **Upload ISO to vSphere**

Upload your Debian ISO to a datastore in vSphere. The path should be in the format:
```
[datastore-name] ISOs/debian-12.11.0-amd64-netinst.iso
```

### **Add Your Public SSH Key**

Place your public SSH key in the `cloud.cfg` file under `ssh_authorized_keys`:
```yaml
ssh_authorized_keys:
  - ssh-rsa AAAAB3... your_key_comment
```

### **Initialize Packer**
   ```bash
   packer init .
   ```

### **Build the Template**
   ```bash
   packer build .
   ```

## vSphere-Specific Notes

- The template will be created directly in vSphere as a VM template
- Uses thin provisioning for disk space efficiency
- Supports vSphere features like resource pools and folders
- SSH access is configured for root user with password "packer"
- The VM will be automatically converted to a template after build

# Note
The default user is: `root`.
