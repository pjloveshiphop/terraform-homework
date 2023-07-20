# =============== provided as output(s) =======================================================
variable vpc_id {
    type = string
    description = "vpc id provided as output from vpc module"
}

# =============== module variable(s) =======================================================
variable "sg_config" {
    type = map(object({
      sg_nm = string
      description = string
    }))
}

variable sg_ingress_rule {
  type = list(object({
    sg_nm = string
    cidr_blocks = list(string)
    prefix_list_ids = list(string)
    from_port = number
    to_port = number
    protocol = string
    source_security_group_id = string
    self = bool
    description = string
  }))
}