output "name" {
  value = "${openstack_compute_instance_v2.server.*.name}"
}

output "id" {
  value = "${openstack_compute_instance_v2.server.*.id}"
}

output "ip" {
  value = "${openstack_compute_instance_v2.server.*.network.0.fixed_ip_v4}"
}

output "floatip" {
  value = "${openstack_networking_floatingip_v2.floatip.*.address}"
}

