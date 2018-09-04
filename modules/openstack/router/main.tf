data "openstack_networking_network_v2" "external_network" {
  name = "${var.external_network_name}"
  external = true
}

resource "openstack_networking_router_v2" "router" {
  name = "${var.name}"
  external_network_id = "${data.openstack_networking_network_v2.external_network.id}"
  admin_state_up = "true"
}

resource "openstack_networking_router_interface_v2" "route_interface" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${var.subnet_id}"
}