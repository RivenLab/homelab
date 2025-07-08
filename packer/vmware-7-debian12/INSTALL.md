# Installation Guide for vSphere Packer Templates

## Prerequisites

Before you begin, ensure you have the following:

### Required Software
- **Packer**: Version 1.12.0 or higher
- **Git**: For cloning the repository
- **SSH Key**: Your public SSH key for secure access

### vSphere Requirements
- **vCenter Server**: Version 6.7 or higher
- **ESXi Host**: Version 6.7 or higher
- **Datastore**: Sufficient storage space (at least 20GB free)
- **Network**: Accessible network for the VM

## Step-by-Step Installation

### Step 1: Install Packer

#### On Ubuntu/Debian:
```bash
# Add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update and install Packer
sudo apt update
sudo apt install packer
```

#### On CentOS/RHEL:
```bash
# Add HashiCorp repository
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

# Install Packer
sudo yum install packer
```

#### On macOS:
```bash
# Using Homebrew
brew install packer

# Or download directly
curl -fsSL https://releases.hashicorp.com/packer/1.12.0/packer_1.12.0_darwin_amd64.zip -o packer.zip
unzip packer.zip
sudo mv packer /usr/local/bin/
```

### Step 2: Clone the Repository

```bash
git clone https://github.com/RivenLab/packer-vsphere-templates.git
cd packer-vsphere-templates
```

### Step 3: Prepare Your Environment

#### 3.1 Copy the Variables File
```bash
cp example-variables.pkrvars.hcl variables.auto.pkrvars.hcl
```

#### 3.2 Edit the Variables File
Open `variables.auto.pkrvars.hcl` and update with your vSphere environment details:

```hcl
# vSphere Connection Settings
vsphere_endpoint         = "your-vcenter-ip"
vsphere_username         = "administrator@vsphere.local"
vsphere_password         = "your-vcenter-password"
vsphere_insecure_connection = true

# vSphere Infrastructure Settings
vsphere_datacenter    = "your-datacenter-name"
vsphere_cluster       = "your-cluster-name"
vsphere_host          = "your-esxi-host-ip"
vsphere_datastore     = "your-datastore-name"
vsphere_folder        = "Templates"
vsphere_resource_pool = "Resources"
vsphere_network       = "your-network-name"

# VM Configuration
vm_name             = "template-debian-12"
iso_file            = "[your-datastore] ISOs/debian-12.11.0-amd64-netinst.iso"
memory              = "1024"
cores               = "2"
disk_size           = "20480"
```

### Step 4: Upload ISO to vSphere

#### 4.1 Download Debian ISO
```bash
# Download Debian 12.11.0 ISO
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.11.0-amd64-netinst.iso
```

#### 4.2 Upload to vSphere Datastore
1. **Using vSphere Web Client:**
   - Log into vCenter
   - Navigate to your datastore
   - Create a folder called "ISOs"
   - Upload the Debian ISO to this folder

2. **Using vSphere CLI (if available):**
   ```bash
   # Upload using ovftool or vSphere CLI
   ovftool debian-12.11.0-amd64-netinst.iso vi://username:password@vcenter/datastore/ISOs/
   ```

### Step 5: Configure SSH Key

#### 5.1 Generate SSH Key (if you don't have one)
```bash
ssh-keygen -t rsa -b 4096 -C "your-email@example.com"
```

#### 5.2 Add SSH Key to cloud.cfg
Edit the `cloud.cfg` file and add your public key:

```yaml
# Add your SSH public key here
ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2E... your-key-here
```

### Step 6: Initialize Packer

```bash
# Initialize Packer and download required plugins
packer init .
```

This will download the vSphere plugin and any other required components.

### Step 7: Validate Configuration

```bash
# Validate your Packer configuration
packer validate .
```

This will check your configuration for syntax errors and missing variables.

### Step 8: Build the Template

```bash
# Build the template
packer build .
```

The build process will:
1. Create a VM in vSphere
2. Boot from the Debian ISO
3. Install Debian using the preseed configuration
4. Configure the system with your settings
5. Convert the VM to a template

## Troubleshooting

### Common Issues

#### 1. Connection Issues
```bash
# Test vSphere connectivity
curl -k https://your-vcenter-ip/sdk

# Check credentials
packer validate -var-file=variables.auto.pkrvars.hcl .
```

#### 2. ISO Path Issues
- Ensure the ISO path format is correct: `[datastore] path/to/iso`
- Verify the ISO exists in the specified location
- Check datastore permissions

#### 3. Network Issues
- Verify the network name exists in vSphere
- Check that the network is accessible from the target host
- Ensure DHCP is available on the network

#### 4. Build Failures
```bash
# Run with debug output
packer build -debug .

# Check logs
tail -f ~/.packer.d/logs/packer.log
```

### Debug Commands

```bash
# Validate with specific variables
packer validate -var-file=variables.auto.pkrvars.hcl .

# Build with specific variables
packer build -var-file=variables.auto.pkrvars.hcl .

# Force build (ignore existing artifacts)
packer build -force .
```

## Post-Installation

### Verify Template Creation
1. Log into vCenter
2. Navigate to your Templates folder
3. Verify the template was created successfully
4. Check the template properties and settings

### Using the Template
1. Right-click on the template
2. Select "Deploy VM from this Template"
3. Configure the new VM settings
4. Power on and verify functionality

## Security Notes

- Store sensitive passwords in environment variables
- Use SSH keys instead of passwords when possible
- Regularly update the template with security patches
- Consider using vSphere roles with minimal required permissions

## Support

For issues or questions:
- Check the Packer documentation: https://www.packer.io/docs
- Review vSphere documentation: https://docs.vmware.com/
- Check the project repository for updates