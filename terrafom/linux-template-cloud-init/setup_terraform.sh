#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}Terraform Setup Script${NC}"
echo -e "${BLUE}This script will help you set up missing variables and run terraform apply${NC}\n"

prompt_with_default() {
    local prompt=$1
    local default=$2
    local var_name=$3

    echo -e "${BLUE}$prompt${NC} (default: $default): "
    read input

    if [ -z "$input" ]; then
        input=$default
    fi

    eval "$var_name=\"$input\""
    echo "Setting $var_name = $input"
}

prompt_with_default "Enter cloned VM ID" "601" "clone_vm_id"
prompt_with_default "Enter VM name" "debian-vm" "vm_name"
prompt_with_default "Enter VM description" "Debian 12 VM created with Terraform" "vm_description"
prompt_with_default "Enter number of CPU cores" "2" "cpu_cores"
prompt_with_default "Enter memory in MB" "2048" "memory_value"

prompt_with_default "Enter disk size in GIB" "20" "disk_size"

prompt_with_default "Enter IP address" "10.20.20.150" "ip_address"

cat > terraform.tfvars.json << EOF
{
  "clone_vm_id": $clone_vm_id,
  "vm_name": "$vm_name",
  "vm_description": "$vm_description",
  "cpu_cores": $cpu_cores,
  "memory_dedicated": $memory_value,
  "disk_size": $disk_size,
  "ip_address": "$ip_address/24"
}
EOF

echo -e "\n${GREEN}Created terraform.tfvars.json with your values${NC}"

echo -e "\n${GREEN}Running terraform init...${NC}"
terraform init

echo -e "\n${GREEN}Running terraform plan...${NC}"
terraform plan

echo -e "\n${GREEN}Do you want to apply these changes? (y/n)${NC}"
read -r confirm

if [ -z "$confirm" ]; then
    confirm="y"
fi

if [[ $confirm == "y" || $confirm == "Y" ]]; then
    echo -e "\n${GREEN}Running terraform apply with auto-approve...${NC}"
    terraform apply -auto-approve

    # Cleanup terraform files
    echo -e "\n${GREEN}Cleaning up terraform files...${NC}"
    rm -f terraform.tfstate terraform.tfstate.backup terraform.tfvars.json
else
    echo -e "\n${BLUE}Terraform apply cancelled.${NC}"
fi
