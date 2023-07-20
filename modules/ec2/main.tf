resource "aws_key_pair" "key_pair" {
  for_each   = var.key_config
  key_name   = each.key
  public_key = file(each.value.public_key_path)
  tags = {
    Name = each.key
  }
}

data "aws_availability_zones" "azs" {}

# data "aws_ami" "ubuntu" {
#     most_recent = true
#     filter {
#         name = "name"
#         values = ["*22.04*"]
#     }
#     filter {
#         name = "virtualization-type"
#         values = ["hvm"]
#     }
#     filter {
#         name   = "root-device-type"
#         values = ["ebs"]
#     }
#     filter {
#         name = "architecture"
#         values = ["x86_64"]
#     }

# }

resource "aws_instance" "instance" {
  count                  = length(data.aws_availability_zones.azs.names)
  ami                    = var.ec2_config[count.index].ami
  availability_zone      = data.aws_availability_zones.azs.names[count.index]
  ebs_optimized          = true
  instance_type          = var.ec2_config[count.index].instance_type
  key_name               = var.ec2_config[count.index].key_nm
  monitoring             = var.ec2_config[count.index].monitoring
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.public_subnet_ids[count.index]
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    iops                  = try(var.ec2_config[count.index].root_block_iops, null)
    volume_type           = try(var.ec2_config[count.index].root_block_vol_type, null)
    volume_size           = try(var.ec2_config[count.index].root_block_vol_size, null)
    throughput            = try(var.ec2_config[count.index].root_block_throughput, null)
    tags = {
      Name = try(var.ec2_config[count.index].root_block_nm, null)
    }
  }
  tags = {
    Name = var.ec2_config[count.index].instance_nm
  }
}
