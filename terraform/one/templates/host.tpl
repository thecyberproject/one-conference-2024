[ad_windows]
%{ for ip in ads ~}
${ip}
%{ endfor ~}

[stackstate_server]
v2412.stackstate ansible_host=${stackstate}

[server_windows]
%{ for ip in servers ~}
${ip}
%{ endfor ~}

[ghosts_server]
v2412.ghosts-server ansible_host=${ghosts_server_addr}

[clients_windows]
%{ for ip in clients ~}
${ip}
%{ endfor ~}

[all:vars]
ansible_connection=ssh
ansible_ssh_user=ansible
ansible_ssh_pass=H@ck3rHenr#y132
ansible_ssh_private_key_file=/root/.ssh/id_ed25519

[ad_windows:vars]
ansible_user=tnoadmin
ansible_password=TNO_default_password12
ansible_connection=winrm
ansible_winrm_transport=basic
ansible_winrm_server_cert_validation=ignore
ansible_port=5985
ansible_winrm_scheme=http

[server_windows:vars]
ansible_user=tnoadmin
ansible_password=TNO_default_password12
ansible_connection=winrm
ansible_winrm_transport=basic
ansible_winrm_server_cert_validation=ignore
ansible_port=5985
ansible_winrm_scheme=http

[clients_windows:vars]
ansible_user=tnoadmin
ansible_password=TNO_default_password12
ansible_connection=winrm
ansible_winrm_transport=basic
ansible_winrm_server_cert_validation=ignore
ansible_port=5985
ansible_winrm_scheme=http