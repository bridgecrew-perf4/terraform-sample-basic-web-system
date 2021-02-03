resource "aws_instance" "ap_a" {
  ami               = var.ami_ap
  instance_type     = var.instance_type_ap
  availability_zone = var.az_a
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
    encrypted             = false
    tags = {
      Name = "${var.system_name}_ap_a"
      Env  = var.env["stg"]
    }
  }
  iam_instance_profile                 = "web"
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"
  key_name                             = var.key_pair_name
  monitoring                           = false
  vpc_security_group_ids               = [aws_security_group.ap.id]
  subnet_id                            = aws_subnet.private_a.id
  associate_public_ip_address          = false
  source_dest_check                    = true
  # user_data = file("${path.module}/userdata.sh")
  hibernation = false
  tags = {
    Name = "${var.system_name}_ap_a"
    Env  = var.env["stg"]
  }
}

resource "aws_instance" "ap_c" {
  ami               = var.ami_ap
  instance_type     = var.instance_type_ap
  availability_zone = var.az_c
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
    encrypted             = false
    tags = {
      Name = "${var.system_name}_ap_c"
      Env  = var.env["stg"]
    }
  }
  iam_instance_profile                 = "web"
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"
  key_name                             = var.key_pair_name
  monitoring                           = false
  vpc_security_group_ids               = [aws_security_group.ap.id]
  subnet_id                            = aws_subnet.private_c.id
  associate_public_ip_address          = false
  source_dest_check                    = true
  # user_data = file("${path.module}/userdata.sh")
  hibernation = false
  tags = {
    Name = "${var.system_name}_ap_c"
    Env  = var.env["stg"]
  }
}
