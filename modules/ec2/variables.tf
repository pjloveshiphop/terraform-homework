# =============== provided as output(s) =======================================================
variable public_subnet_ids {
    type = list(string)
    description = "list of public subnet ids"
}

variable "security_group_ids" {
    type = list(string)
    description = "list of security group ids"
}

# =============== module variable(s) =======================================================
variable "key_config" {
    type = map(object({
        public_key_path= string
    }))
    description = "key pair config"
}

variable "ec2_config" {
    type = list(object({
        ami = string
        instance_nm = string
        instance_type = string
        key_nm = string
        monitoring = bool
        root_block_nm = string
        root_block_vol_type = string
        root_block_vol_size = number
        root_block_iops = number
        root_block_throughput = number
    }))
}