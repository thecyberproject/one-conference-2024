module "ad" {
  count = 1

  source         = "../windows-base"
  vm_name        = "ONEC-Windows-Server-2019-AD"
  vm_description = "Windows AD Server"

  vm_id                  = 630
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
        storage = "nvme"
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

  vm_id                  = 640 + count.index + 1
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
        storage = "nvme"
        size    = 50
        format  = "raw"
      }
    }
  ]

}

resource "local_file" "hosts_cfg" {
  depends_on = [
    module.ad,
    module.client
  ]
  content = templatefile("${path.module}/templates/host.tpl",
    {
      ads     = module.ad[*].ipv4_address
      clients = module.client[*].ipv4_address
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
