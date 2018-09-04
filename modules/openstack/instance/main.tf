
data "openstack_images_image_v2" "image" {
  name = "${var.os}"
  most_recent = true

  properties {
    key = "value"
  }
}

resource "openstack_blockstorage_volume_v2" "disk_root" {
    count = "${var.count}"
    name        = "disk_${var.name}${count.index}_root"
    region      = "${var.region}"
    image_id    = "${data.openstack_images_image_v2.image.id}"
    size        = "${var.storage_size}"
    volume_type = "${var.storage_type}"
    lifecycle {
        prevent_destroy = true
    }
}

resource "openstack_compute_instance_v2" "server" {
    count       = "${var.count}"
    name        = "${var.name}${count.index}"
    flavor_name = "${var.flavor}"
    region      = "${var.region}"
    key_pair    = "${var.keys}"

    network {
        uuid        = "${var.network_id}"
    }


    metadata = {
        "x_sel_server_default_addr"  = "{\"ipv4\":\"\"}"
    }


    block_device {
        uuid   = "${openstack_blockstorage_volume_v2.disk_root.*.id[count.index]}"
        source_type      = "volume"
        boot_index       = 0
        destination_type = "volume"
    }
}

resource "openstack_networking_floatingip_v2" "floatip" {
    count = "${var.floatip ? var.count : 0}"
    pool = "${var.floatip_pool}"
}

resource "openstack_compute_floatingip_associate_v2" "floatip_associate" {
    count = "${var.floatip ? var.count : 0}"
    floating_ip = "${element(openstack_networking_floatingip_v2.floatip.*.address, count.index)}"
    instance_id = "${element(openstack_compute_instance_v2.server.*.id, count.index)}"
}