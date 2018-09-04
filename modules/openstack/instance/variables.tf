variable "name"         { }

variable "count" {
  default = 1
}

variable "region" {
    default = ""
}

variable "storage_type" { }
variable "storage_size" { }
variable "os"        { }
variable "flavor"       { }
variable "network_id"   { }

variable "keys" {
    #type = "list"
}

variable "floatip" {  
    default = false
}

variable "floatip_pool" {
    default = "external-network"
}
