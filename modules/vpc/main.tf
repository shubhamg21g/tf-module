resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = merge(var.tags, {Name = "${var.appname}-${var.env}-myvpc"})
}

resource "aws_subnet" "public" {
  count = length(var.public_cidr_block)
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public_cidr_block[count.index]
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = "true"

  tags = merge(var.tags, {Name = "${var.appname}-${var.env}-public"})
}


resource "aws_subnet" "private" {
  count = length(var.private_cidr_block)
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.private_cidr_block[count.index]
  availability_zone = element(var.azs, count.index)

  tags = merge(var.tags, {Name = "${var.appname}-${var.env}-private"})
}