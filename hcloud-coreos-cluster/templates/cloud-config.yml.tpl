#cloud-config

hostname: "${hostname}"

coreos:
  fleet:
    public-ip: "$public_ipv4"
    metadata: "region=${region}"

ssh_authorized_keys:
  - ${ssh_key_public}
