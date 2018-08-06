
# provider "openstack" {
#   domain_name = "${var.OPENSTACK_ACCOUNT}"
#   auth_url    = "${var.OPENSTACK_AUTH_URL}"
#   tenant_name = "${var.OPENSTACK_PROJECTID}"
#   tenant_id   = "${var.OPENSTACK_PROJECTID}"
#   user_name   = "${var.OPENSTACK_USER}"
#   password    = "${var.OPENSTACK_PASSWORD}"
# }

resource "openstack_compute_keypair_v2" "public_key" {
    count = "${var.generate ? 0 : 1}"
    name = "${var.name}"
    region = "${var.region}"
    public_key = "${file(var.public_key)}"
}

resource "openstack_compute_keypair_v2" "generated_public_key" {
    count = "${var.generate ? 1 : 0}"
    name  = "${var.name}"
    region = "${var.region}"
}