# Virtual Machines

## CentOS7 VM

### Master 1

resource "azurerm_public_ip" "centossbdpip" {
  name                = "centossbdpip"
  resource_group_name = azurerm_resource_group.ansiblepoc.name
  location            = azurerm_resource_group.ansiblepoc.location
  allocation_method   = "Dynamic"

  tags = {
    environment  = "CentOS-POC"
    org          = "rps-latam"
    appid-or-sso = "fabi8483"
  }
}

resource "azurerm_network_interface" "centossbdnic1" {
  name                = "centossbdnic1"
  location            = azurerm_resource_group.ansiblepoc.location
  resource_group_name = azurerm_resource_group.ansiblepoc.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.centossbdsn1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.centossbdpip.id
  }
  tags = {
    environment  = "CentOS-POC"
    org          = "rps-latam"
    appid-or-sso = "fabi8483"
  }
}

resource "azurerm_linux_virtual_machine" "centossbd" {
  name                = "centossbd"
  resource_group_name = azurerm_resource_group.ansiblepoc.name
  location            = azurerm_resource_group.ansiblepoc.location
  size                = "Standard_A4_v2"
  admin_username      = "centos"
  network_interface_ids = [
    azurerm_network_interface.centossbdnic1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  admin_ssh_key {
    username   = "centos"
    public_key = file("~/fabs.pub")
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }
  tags = {
    environment  = "CentOS-POC"
    org          = "rps-latam"
    appid-or-sso = "fabi8483"
  }
}

