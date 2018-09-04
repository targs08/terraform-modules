variable "name" {
  description = "A unique name for the resource"
}

variable "description" {
  description = " A description for the security group"
}

variable "from_port" {
  description = "An integer representing the lower bound of the port range to open"
}

variable "to_port" {
  description = "An integer representing the upper bound of the port range to open"
}

variable "ip_protocol" {
  description = "The protocol type that will be allowed"
}

variable "cidr" {
  description = "The IP range that will be the source of network traffic to the security group. Use 0.0.0.0/0 to allow all IP addresses"
}