resource "aws_vpc" "cpk-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Terraform   = "true"
    Author      = "fabiocicerchia"
    Environment = "base"
    Service     = "cloud-phoenix-kata"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "cpk-zones" {
  count                   = 3
  vpc_id                  = aws_vpc.cpk-vpc.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Terraform   = "true"
    Author      = "fabiocicerchia"
    Environment = "base"
    Service     = "cloud-phoenix-kata"
  }
}

resource "aws_internet_gateway" "cpk-igw" {
  vpc_id = aws_vpc.cpk-vpc.id

  tags = {
    Terraform   = "true"
    Author      = "fabiocicerchia"
    Environment = "base"
    Service     = "cloud-phoenix-kata"
  }
}

resource "aws_route_table" "cpk-rt" {
  vpc_id = aws_vpc.cpk-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cpk-igw.id
  }

  tags = {
    Terraform   = "true"
    Author      = "fabiocicerchia"
    Environment = "base"
    Service     = "cloud-phoenix-kata"
  }
}

resource "aws_route_table_association" "cpk-rt_zone" {
  count          = 3
  route_table_id = aws_route_table.cpk-rt.id
  subnet_id      = aws_subnet.cpk-zones[count.index].id
}
