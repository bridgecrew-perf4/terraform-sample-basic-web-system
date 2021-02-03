##################################################
# public subnet
##################################################
resource "aws_subnet" "public_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block_public_a
  availability_zone = var.az_a

  tags = {
    Name = "${var.system_name}_public_a"
    Env  = var.env["stg"]
  }
}

resource "aws_subnet" "public_c" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block_public_c
  availability_zone = var.az_c

  tags = {
    Name = "${var.system_name}_public_c"
    Env  = var.env["stg"]
  }
}

resource "aws_route_table" "public_a" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.system_name}_public_a"
    Env  = var.env["stg"]
  }
}

resource "aws_route_table" "public_c" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.system_name}_public_c"
    Env  = var.env["stg"]
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_a.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public_c.id
}

resource "aws_route" "bastion_az_a" {
  route_table_id         = aws_route_table.public_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route" "bastion_az_c" {
  route_table_id         = aws_route_table.public_c.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

##################################################
# private subnet
##################################################
resource "aws_subnet" "private_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block_private_a
  availability_zone = var.az_a

  tags = {
    Name = "${var.system_name}_private_a"
    Env  = var.env["stg"]
  }
}

resource "aws_subnet" "private_c" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block_private_c
  availability_zone = var.az_c

  tags = {
    Name = "${var.system_name}_private_c"
    Env  = var.env["stg"]
  }
}

resource "aws_route_table" "private_a" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.system_name}_private_a"
    Env  = var.env["stg"]
  }
}

resource "aws_route_table" "private_c" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.system_name}_private_c"
    Env  = var.env["stg"]
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_c.id
}

##################################################
# secure subnet
##################################################
resource "aws_subnet" "secure_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block_secure_a
  availability_zone = var.az_a

  tags = {
    Name = "${var.system_name}_secure_a"
    Env  = var.env["stg"]
  }
}

resource "aws_subnet" "secure_c" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block_secure_c
  availability_zone = var.az_c

  tags = {
    Name = "${var.system_name}_secure_c"
    Env  = var.env["stg"]
  }
}
