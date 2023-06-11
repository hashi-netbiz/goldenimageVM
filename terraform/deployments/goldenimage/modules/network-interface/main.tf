resource "random_integer" "random_number" {
  min = 100
  max = 999
}

# Create public IPs
resource "azurerm_public_ip" "nic_public_ip" {
  name                = "${var.vmname}_ip"
  location            = var.location
  resource_group_name = var.resource_group_name 
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
    name                = "${var.vmname}${random_integer.random_number.result}"
    location            = var.location
    resource_group_name = var.resource_group_name    
    
    ip_configuration {
        name                          = "my_nic_configuration"
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.nic_public_ip.id
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "ssh_nsg" {
  name                = "${var.vmname}${random_integer.random_number.result}_nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "ssh-nsg-association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.ssh_nsg.id
}