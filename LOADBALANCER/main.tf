# Launch Template
resource "aws_launch_template" "example" {
  name_prefix   = "example-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    security_groups = [var.public_sg_id]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "example-launch-template"
  }
}

# Auto Scaling Group
#(ASG) instance will be registered automatically with the Target Group through the aws_autoscaling_group resource and the target_group_arns attribute.
resource "aws_autoscaling_group" "example" {
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.subnet_ids

  min_size           = 1
  max_size           = 3
  desired_capacity   = 1
  health_check_type  = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "example-asg"
    propagate_at_launch = true
  }

  target_group_arns = [aws_lb_target_group.example.arn]

  lifecycle {
    create_before_destroy = true
  }
}

# Application Load Balancer
resource "aws_lb" "example" {
  name               = "example-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "example-alb"
  }
}

# Target Group
resource "aws_lb_target_group" "example" {
  name     = "example-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name = "example-tg"
  }
}

# Listener
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}
