output "name" {
  value = "${var.name}"
}

output "id" {
  value = "${openstack_compute_instance_v2.server.*.id}"
}

