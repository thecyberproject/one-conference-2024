[ad_windows]
%{ for ip in ads ~}
${ip}
%{ endfor ~}


[clients_windows]
%{ for ip in clients ~}
${ip}
%{ endfor ~}


[aio]
%{ for ip in wazuh ~}
${ip}
%{ endfor ~}

[soarca]
%{ for ip in soarca ~}
${ip}
%{ endfor ~}

[attackvm]
%{ for ip in attackvm ~}
${ip}
%{ endfor ~}

[all:vars]
ansible_connection=ssh
ansible_ssh_user=ansible
ansible_ssh_pass=censored
ansible_ssh_private_key_file=/root/.ssh/id_ed25519

[ad_windows:vars]
ansible_user=censored
ansible_password=censored
ansible_connection=winrm
ansible_winrm_transport=basic
ansible_winrm_server_cert_validation=ignore
ansible_port=5985
ansible_winrm_scheme=http

[clients_windows:vars]
ansible_user=admin.user
ansible_password=censored
ansible_connection=winrm
ansible_winrm_transport=basic
ansible_winrm_server_cert_validation=ignore
ansible_port=5985
ansible_winrm_scheme=http