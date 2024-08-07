[ad_windows]
%{ for ip in ads ~}
${ip}
%{ endfor ~}


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

[clients_windows:vars]
ansible_user=tnoadmin
ansible_password=TNO_default_password12
ansible_connection=winrm
ansible_winrm_transport=basic
ansible_winrm_server_cert_validation=ignore
ansible_port=5985
ansible_winrm_scheme=http