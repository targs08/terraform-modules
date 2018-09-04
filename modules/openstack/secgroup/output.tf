output "name" {
  description = "The name of the Security Group resource"
  value = "${openstack_compute_secgroup_v2.secgroup.name}"
}