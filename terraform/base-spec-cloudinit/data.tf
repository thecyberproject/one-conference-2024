data "local_file" "ssh_keys" {
  filename  = "${path.module}/static/keys/pub_sshkeys"
}
