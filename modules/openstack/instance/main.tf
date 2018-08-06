
data "openstack_images_image_v2" "image" {
  name = "${var.os}"
  most_recent = true

  properties {
    key = "value"
  }
}

# data "openstack_compute_flavor_v2" "flavor" {
#   vcpus = "${var.flavor_vcpus}"
#   ram   = "${var.flavor_ram}"
#   disk  = "${var.flavor_disk}"
# }

resource "openstack_blockstorage_volume_v2" "disk_root" {
    count = "${var.count}"
    name        = "disk_${var.name}${count.index}_root"
    region      = "${var.region}"
    image_id    = "${data.openstack_images_image_v2.image.id}"
    size        = "${var.storage_size}"
    volume_type = "${var.storage_type}"
    lifecycle {
        prevent_destroy = false
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
    #    fixed_ip_v4 = "${var.server_ip}"
    #  floating_ip = "${var.server_floating_ip}"
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