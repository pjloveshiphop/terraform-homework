data "aws_availability_zones" "azs" {}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_nm
  }
}

resource "aws_subnet" "public" {
  count                   = length(data.aws_availability_zones.azs.names)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index + 100)
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id
  tags = {
    Name = join("-", ["public", data.aws_availability_zones.azs.names[count.index], "subnet"])
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = join("-", [var.vpc_nm, "igw"])
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = join("-", [var.vpc_nm, "public-rtb"])
  }
}

locals {
  public_subnet_ids = tolist(aws_subnet.public.*.id)
}

resource "aws_route_table_association" "public_assc" {
  count          = length(local.public_subnet_ids)
  subnet_id      = local.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public_rtb.id
}
