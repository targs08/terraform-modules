provider "openstack" {
  domain_name = "${var.OPENSTACK_ACCOUNT}"
  auth_url    = "${var.OPENSTACK_AUTH_URL}"
  tenant_name = "${var.OPENSTACK_PROJECTID}"
  tenant_id   = "${var.OPENSTACK_PROJECTID}"
  user_name   = "${var.OPENSTACK_USER}"
  password    = "${var.OPENSTACK_PASSWORD}"
  region      = "${var.OPENSTACK_REGION}"
}