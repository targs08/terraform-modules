
module "selectel-provider" {
    source = "../../modules/openstack/provider"

    OPENSTACK_AUTH_URL = "https://api.selvpc.ru/identity/v3"
    OPENSTACK_PROJECTID = "${var.SELECTEL_PROJECT_ID}"
    OPENSTACK_ACCOUNT   = "${var.SELECTEL_ACCOUNT}"
    OPENSTACK_USER      = "${var.SELECTEL_USERNAME}"
    OPENSTACK_PASSWORD  = "${var.SELECTEL_PASSWORD}"
    OPENSTACK_REGION    = "${var.SELECTEL_REGION}"

}

module "selectel-keypair" {
    source = "../../modules/openstack/keypair"
    name = "main"
    public_key = "~/.ssh/id_rsa.pub"

}
module "selectel-network" {
    source = "../../modules/openstack/network"

    name = "internal"
    cidr = "192.168.0.0/24"

}

module "web-server" {
    source = "../../modules/openstack/instance"
    count = 2
    name = "web"
    os = "Debian 9 (Stretch) 64-bit"
    flavor = "BL1.1-1024"

    network_id = "${module.selectel-network.id}"

    storage_type = "basic.ru-2a"
    storage_size = "10"

    keys = "${module.selectel-keypair.id}"
    
}
