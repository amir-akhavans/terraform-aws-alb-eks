resource "aws_launch_template" "test" {
  name = "test"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  disable_api_termination = false

  ebs_optimized = true

  elastic_gpu_specifications {
    type = "test"
  }

  iam_instance_profile {
    name = "test"
  }

  image_id = var.instance_ami

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  placement {
    availability_zone = "var.launch_az"
  }

  vpc_security_group_ids = ["security_group_id"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }
}




resource "aws_instance" "test" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    Name = "HelloWorld"
  }
}



resource "aws_lb" "test" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.subnet_id]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}
resource "aws_lb_target_group" "test" {
   name        = var.aws_lb_target_group_name
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
}
resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.test.id
  port             = 80
}


resource "aws_eks_cluster" "test" {
  name     = var.eks_name
  role_arn = var.iam_role

  vpc_config {
    subnet_ids = [var.subnet_id]
  }











