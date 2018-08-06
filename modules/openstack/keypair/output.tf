output "name" {
  value = "${var.name}"
}

output "id" {
  value = "${openstack_compute_keypair_v2.public_key.0.id}"
}
