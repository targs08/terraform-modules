output "id" {
  value = "${openstack_blockstorage_volume_v2.disk.id}"
}

output "instance_name" {
  value = "${var.instance_name}"
}

output "device" {
  value = "${openstack_compute_volume_attach_v2.disk_attach.device}"
}
