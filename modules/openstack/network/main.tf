# provider "openstack" {
#   domain_name = "${var.OPENSTACK_ACCOUNT}"
#   auth_url    = "${var.OPENSTACK_AUTH_URL}"
#   tenant_name = "${var.OPENSTACK_PROJECTID}"
#   tenant_id   = "${var.OPENSTACK_PROJECTID}"
#   user_name   = "${var.OPENSTACK_USER}"
#   password    = "${var.OPENSTACK_PASSWORD}"
# }

resource "openstack_networking_network_v2" "network" {
  name   = "${var.name}"
  region = "${var.region}"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet" {
  network_id = "${openstack_networking_network_v2.network.id}"
  region     = "${var.region}"
  cidr       = "${var.cidr}"
}