#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}Terraform Setup Script${NC}"
echo -e "${BLUE}This script will help you set up missing variables and run terraform apply${NC}\n"

prompt_with_default() {
    local prompt=$1
    local default=$2
    local var_name=$3

    echo -e "${BLUE}$prompt${NC} (default: $default): "
    read input

    # Use default if input is empty
    if [ -z "$input" ]; then
        input=$default
    fi

    # Store the value in a variable
    eval "$var_name=\"$input\""
    echo "Setting $var_name = $input"
}

prompt_with_default "Enter VM name" "debian-vm" "vm_name"

prompt_with_default "Enter VM description" "Debian 12 VM created with Terraform" "vm_description"

prompt_with_default "Enter number of CPU cores" "2" "cpu_cores"

memory_value=""
prompt_with_default "Enter memory in MB" "2048" "memory_value"

# IP Address
prompt_with_default "Enter IP address (CIDR format, e.g., 10.20.20.150/24)" "10.20.20.150/24" "ip_address"

cat > terraform.tfvars.json << EOF
{
  "vm_name": "$vm_name",
  "vm_description": "$vm_description",
  "cpu_cores": $cpu_cores,
  "memory_dedicated": $memory_value,
  "memory_floating": $memory_value,
  "ip_address": "$ip_address"
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
else
    echo -e "\n${BLUE}Terraform apply cancelled.${NC}"
fi