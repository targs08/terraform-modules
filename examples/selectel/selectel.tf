module "selectel-provider" {
    source = "../modules/openstack/provider"

    OPENSTACK_AUTH_URL = "https://api.selvpc.ru/identity/v3"
    OPENSTACK_PROJECTID = "${var.SELECTEL_PROJECT_ID}"
    OPENSTACK_ACCOUNT   = "${var.SELECTEL_ACCOUNT}"
    OPENSTACK_USER      = "${var.SELECTEL_USERNAME}"
    OPENSTACK_PASSWORD  = "${var.SELECTEL_PASSWORD}"
    OPENSTACK_REGION    = "${var.SELECTEL_REGION}"

}

module "selectel-keypair" {
    source = "../modules/openstack/keypair"
    name = "mykey"
    public_key = "~/.ssh/id_rsa.pub"
}

module "selectel-network" {
    source = "../modules/openstack/network"

    name = "internal"
    cidr = "192.168.0.0/24"

}

module "router" {
    source = "../modules/openstack/router"
    name = "router"
    subnet_id = "${module.selectel-network.subnet_id}"
    external_network_name = "${var.external_network_name}"
}

module "web-server" {
    source = "../modules/openstack/instance"
    name = "webserver"
    os = "Debian 9 (Stretch) 64-bit"
    flavor = "BL1.1-1024"

    network_id = "${module.selectel-network.id}"

    storage_type = "basic.ru-2a"
    storage_size = "10"

    keys = "${module.selectel-keypair.id}"

    floatip = true
}
module "addition-storage" {
    source = "../modules/openstack/blockstorage"
    name = "media"
    storage_type = "basic.ru-2a"
    storage_size = "30"
    instance_id = "${module.web-server.id[0]}"
    instance_name = "${module.web-server.name[0]}"
}
