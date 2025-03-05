# Packer Proxmox Templates Installation Guide

## Prerequisites

- **Proxmox**: Version 7 or higher
- **Packer**: Version 1 or higher
- **ISO**: ISO file of Debian 11 or Debian 12

## Installation Steps

### **Clone the Repository**
   ```bash
   git clone https://github.com/RivenLab/packer-proxmox-templates.git
   ```
### **Navigate to the Directory**
   ```bash
    cd packer-proxmox-templates
   ```
### **Copy Example Variablescp example-variables.pkrvars.hcl variables.auto.pkrvars.hcl**
   ```bash
   cp example-variables.pkrvars.hcl variables.auto.pkrvars.hcl
   ```
### **Edit Variables**

Open variables.auto.pkrvars.hcl and update it to correspond with your current environment.

### **Add Your Public SSH Key**

Place your public SSH key in the cloud.cfg file under ssh_authorized_keys:ssh_authorized_keys:
  - ssh-rsa AAAAB3... your_key_comment

### **Initialize Packer**
   ```bash
packer init .
   ```

### **Build the Template**
   ```bash
packer build .
   ```

# Note
The default user is: dragon.
