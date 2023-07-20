# module "s3" {
#     source = "../../modules/s3"
#     s3_remote_backend_bucket_nm = var.s3_remote_backend_bucket_nm
# }

# module "dynamodb" {
#     source = "../../modules/dynamodb"
#     dynamodb_remote_backend_table_nm = var.dynamodb_remote_backend_table_nm
# }

module "vpc" {
  source         = "../../modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  vpc_nm         = var.vpc_nm
}

module "sg" {
  source         = "../../modules/sg"
  vpc_id = module.vpc.vpc_id
  sg_config = var.sg_config
  sg_ingress_rule = var.sg_ingress_rule
}

module "ec2" {
  source = "../../modules/ec2"
  key_config = var.key_config
  public_subnet_ids = module.vpc.public_subnet_ids
  ec2_config = var.ec2_config
  security_group_ids = [module.sg.ec2_sg_id]
}
