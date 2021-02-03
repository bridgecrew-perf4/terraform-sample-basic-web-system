resource "aws_lb" "alb" {
  name               = "alb"
  internal           = true
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.alb.id
  ]
  subnets = [
    aws_subnet.private_a.id,
    aws_subnet.private_c.id
  ]
  # drop_invalid_header_fields = 
  enable_deletion_protection = false
  idle_timeout               = 60
  access_logs {
    bucket  = var.logging_bucket
    prefix  = "alb"
    enabled = true
  }
  tags = {
    Name = "${var.system_name}_alb"
    Env = var.env["stg"]
  }
}

resource "aws_lb_target_group" "ap" {
  name                          = "ap"
  port                          = 80
  protocol                      = "HTTP"
  deregistration_delay          = "300"
  slow_start                    = 0
  load_balancing_algorithm_type = "round_robin"
  target_type                   = "instance"
  vpc_id                        = var.vpc_id

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400
    enabled         = false
  }

  health_check {
    enabled             = true
    interval            = 6
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-299"
  }

  tags = {
    Env = var.env["stg"]
  }
}

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = ""

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.ap.arn
#   }
# }

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ap.arn
  }
}

# resource "aws_lb_listener" "http_redirect_https" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"
#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

resource "aws_lb_target_group_attachment" "ap_a" {
  target_group_arn = aws_lb_target_group.ap.arn
  target_id = aws_instance.ap_a.id
  port = 80
}

resource "aws_lb_target_group_attachment" "ap_c" {
  target_group_arn = aws_lb_target_group.ap.arn
  target_id = aws_instance.ap_c.id
  port = 80
}

resource "aws_elb" "this" {
  name               = "clb"
  # availability_zones = [var.az_a, var.az_c]
  subnets = [ aws_subnet.private_a.id, aws_subnet.private_c.id ]
  internal = true

  access_logs {
    bucket        = var.logging_bucket
    bucket_prefix = "clb"
    interval      = 60
  }

  listener {
    instance_port     = 22
    instance_protocol = "tcp"
    lb_port           = 10022
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.ap_a.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elb"
  }
}
