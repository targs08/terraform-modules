resource "openstack_compute_secgroup_v2" "secgroup" {
  name        = "${var.name}"
  description = "${var.description}"

  rule {
    from_port   = "${var.from_port}"
    to_port     = "${var.to_port}"
    ip_protocol = "${var.ip_protocol}"
    cidr        = "${var.cidr}"
  }
}
