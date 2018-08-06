resource "openstack_blockstorage_volume_v2" "disk" {
    name        = "disk_${var.name}"
    region      = "${var.region}"
    size        = "${var.storage_size}"
    volume_type = "${var.storage_type}"
    lifecycle {
        prevent_destroy = false
    }
}