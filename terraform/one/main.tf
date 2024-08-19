module "soarca" {
  count               = 1
  source              = "../base-spec-cloudinit"
  vm_name             = "ONEC-Soarca"
  vm_description      = "Soarca for the one-conference"
  vm_id               = 1312
  template_clone      = "ubuntu-server-22.04-cloud-init-template-csthv04"
  template_full_clone = true
  admin_username      = "ansible"
  admin_password      = "vErYSecureOneConf"
  ssh_empty           = false

  default_ci_cdrom_storage = var.proxmox_storage

  proxmox_node           = "csthv04"
  primary_network_bridge = "vlan131"

  networks = [
    {
      bridge = "vlan131"
    },
  ]

  primary_network_cidr_address = "192.168.1.231/24"
  primary_network_gateway      = "192.168.1.1"

  cores  = 4
  memory = 4096

  disks = [
    {
      virtio0 = {
        storage = var.proxmox_storage
        size    = 30
        format  = "raw"
      }
    }
  ]

  tags = [
    "Soarca",
    "ONE-Conference",
  ]
}

module "attackvm" {
  count               = 1
  source              = "../base-spec-cloudinit"
  vm_name             = "Attacker"
  vm_description      = "AttackerVM for the one-conference"
  vm_id               = 1313
  template_clone      = "ubuntu-server-22.04-cloud-init-template-csthv04"
  template_full_clone = true
  admin_username      = "ansible"
  admin_password      = "vErYSecureOneConf"
  ssh_empty           = false

  default_ci_cdrom_storage = var.proxmox_storage

  proxmox_node           = "csthv04"
  primary_network_bridge = "vlan132"

  networks = [
    {
      bridge = "vlan132"
    },
  ]

  primary_network_cidr_address = "192.168.2.230/24"
  primary_network_gateway      = "192.168.1.1"

  cores  = 4
  memory = 4096

  disks = [
    {
      virtio0 = {
        storage = var.proxmox_storage
        size    = 30
        format  = "raw"
      }
    }
  ]

  tags = [
    "Attackvm",
    "ONE-Conference",
  ]
}

module "wazuh" {
  count               = 1
  source              = "../base-spec-cloudinit"
  vm_name             = "ONEC-Wazuh"
  vm_description      = "Wazuh for the one-conference"
  vm_id               = 1314
  template_clone      = "ubuntu-server-22.04-cloud-init-template-csthv04"
  template_full_clone = true
  admin_username      = "ansible"
  admin_password      = "vErYSecureOneConf"
  ssh_empty           = false

  default_ci_cdrom_storage = var.proxmox_storage

  proxmox_node           = "csthv04"
  primary_network_bridge = "vlan131"

  networks = [
    {
      bridge = "vlan131"
    },
  ]

  primary_network_cidr_address = "192.168.1.230/24"
  primary_network_gateway      = "192.168.1.1"

  cores  = 4
  memory = 4096

  disks = [
    {
      virtio0 = {
        storage = var.proxmox_storage
        size    = 30
        format  = "raw"
      }
    }
  ]

  tags = [
    "wazuh",
    "ONE-Conference",
  ]
}



module "ad" {
  count = 1

  source         = "../windows-base"
  vm_name        = "ONEC-Windows-Server-2019-AD"
  vm_description = "Windows AD Server"

  vm_id                  = 1315
  template_clone         = "Windows-Server-2019-ga-template-csthv04"
  template_full_clone    = true
  proxmox_node           = var.proxmox_node
  primary_network_bridge = "vlan131"
  cores                  = 2
  memory                 = 4096
  tags = [
    "windows", "AD", "ONE-Conference", "2019"
  ]

  disks = [
    {
      virtio0 = {
        storage = var.proxmox_storage
        size    = 50
        format  = "raw"
      }
    }
  ]

}

module "client" {
  count = 3

  source         = "../windows-base"
  vm_name        = format("ONEC-Windows-10-%03d", count.index + 1)
  vm_description = "ONEC-Windows netwerk server"

  vm_id                  = 1316 + count.index + 1
  template_clone         = "Windows-10-22H2-ga-template-csthv04"
  template_full_clone    = true
  proxmox_node           = var.proxmox_node
  primary_network_bridge = "vlan131"
  cores                  = 2
  memory                 = 4096
  tags = [
    "windows", "ONE-Conference", "22H2"
  ]

  disks = [
    {
      virtio0 = {
        storage = var.proxmox_storage
        size    = 50
        format  = "raw"
      }
    }
  ]

}

resource "local_file" "hosts_cfg" {
  depends_on = [
    module.ad,
    module.client,
    module.wazuh
  ]
  content = templatefile("${path.module}/templates/host.tpl",
    {
      ads      = module.ad[*].ipv4_address
      clients  = module.client[*].ipv4_address
      wazuh    = module.wazuh[*].ipv4_address
      soarca   = module.soarca[*].ipv4_address
      attackvm = module.attackvm[*].ipv4_address
    }
  )
  filename = "../../ansible/hosts.ini"
}

resource "null_resource" "install" {
  depends_on = [
    module.ad,
    local_file.hosts_cfg,
  ]
  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook ../../ansible/windows/ad/install_ad.yaml -i ../../ansible/hosts.ini -vvv"
  }
}

resource "null_resource" "enroll" {
  depends_on = [
    module.ad,
    module.client,
    local_file.hosts_cfg,
    null_resource.install,
  ]
  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook ../../ansible/windows/client/enroll_client_into_ad.yaml -i ../../ansible/hosts.ini -vvv"
  }
}

resource "null_resource" "wazuh_install" {
  depends_on = [
    module.wazuh,
    null_resource.enroll
  ]
  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook ../../ansible/wazuh/v4_8_1/playbooks/wazuh-single-secure.yml -i ../../ansible/hosts.ini -vvv"
  }
}

resource "null_resource" "soarca_install" {
  depends_on = [
    module.soarca,
    null_resource.enroll
  ]
  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook ../../ansible/docker/install_docker.yaml -i ../../ansible/hosts.ini -vvv"
  }
}



