resource "openstack_blockstorage_volume_v2" "disk" {
    name        = "disk_${var.name}"
    region      = "${var.region}"
    size        = "${var.storage_size}"
    volume_type = "${var.storage_type}"
    lifecycle {
        prevent_destroy = false
    }
}

resource "openstack_compute_volume_attach_v2" "disk_attach" {
    instance_id = "${var.instance_id}"
    volume_id   = "${openstack_blockstorage_volume_v2.disk.id}"
}