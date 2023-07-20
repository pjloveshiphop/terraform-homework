variable "aws_account_id" {
  type        = string
  description = "aws account id which terraform resources will be created into"
}

variable "aws_region" {
  type        = string
  description = "aws region which terraform resources will be created into"
}

variable "shared_config_file" {
  type        = string
  description = "path(s) of aws config file"
}

variable "shared_credentials_files" {
  type        = string
  description = "path(s) of aws credential file"
}

variable "aws_config_profile" {
  type        = string
  description = "aws config profile"
}

variable "terraform_repo_name" {
  type        = string
  description = "terraform code repo name"
  default     = "terraform-repo"
}

variable "env" {
  type        = string
  description = "envrionment"
}

variable "maintainer" {
  type        = string
  description = "terraform code maintainer"
  default     = "patrick"
}

variable "dynamodb_remote_backend_table_nm" {
  type        = string
  description = "name of dynamodb table for remote backend"
  default     = "dummy-terraform-state-locking"
}

variable "s3_remote_backend_bucket_nm" {
  type        = string
  description = "s3 remote backend bucket name"
  default     = "dummy-s3-remote-backend"
}

variable "vpc_cidr_block" {
  type        = string
  description = "cidr block of vpc"
}
variable "vpc_nm" {
  type        = string
  description = "name of vpc"
}

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

variable "key_config" {
    type = map(object({
        public_key_path= string
    }))
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
