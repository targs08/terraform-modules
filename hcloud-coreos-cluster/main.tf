
provider "hcloud" {
  token = "${var.HCLOUD_TOKEN}"
}

resource "hcloud_keypair" "keypair" {
  name = "${var.name_prefix}.init"
  public_key = "${var.ssh_public_key}"

  lifecycle {
      create_before_destroy = true
  }
}

resource "random_shuffle" "server_region" {
  input = "${var.HCLOUD_AVAILABLE_DC}"
  result_count = "${var.servers_count}"
}

locals {
  region = "${random_shuffle.server_region.result}"
}

data "template_file" "cloud-config" {
  count = "${var.count}"
  template = "${file("${path.module}/templates/cloud-config.yml.tpl")}"

  vars {
    hostname = "${var.servers_name_prefix}${count.index}"
    region = "${local.region[count.index]}"
    ssh_key_public = "${var.ssh_key_public}"
  }
}

resource "hcloud_server" "servers" {
  count = "${var.count}"
  name = "${var.servers_name_prefix}${count.index}"
  image = "debian-9"
  server_type = "${var.HCLOUD_INSTANCE_TYPE}"
  ssh_keys = [ "${hcloud_keypair.keypair.id}" ]
  datacenter = "${local.region[count.index]}"
  rescue = "linux64"

  connection {
    timeout = "10m"
    private_key = "${var.ssh_key_private}"
  }

  provisioner "file" {
    content     = "${data.template_file.cloud-config.*.rendered[count.index]}"
    destination = "/root/cloud-config.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "wget https://raw.github.com/coreos/init/master/bin/coreos-install", 
      "chmod +x coreos-install",
      "./coreos-install -d /dev/sda -c /root/cloud-config.yml",
      "reboot"
    ]
  }

  provisioner "local-exec" {
      command = "sleep 60"
  }

}