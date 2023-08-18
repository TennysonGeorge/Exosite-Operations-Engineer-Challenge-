provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Security group for EC2 instance"
  vpc_id      = "vpc-00917d332f96d91a5"


  ## This allowed us to be able to login to our EC2 instance and perfromance admin task
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ## Ingress trafic control for users 

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## Instance type that we are requireing from AWS 

resource "aws_instance" "nginx_instance" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  associate_public_ip_address = true 
  key_name        = aws_key_pair.nginx_key_pair.key_name

  tags = {
    Name = "NginxInstance"
  }
}

# Name for the key pair and path to the public key

resource "aws_key_pair" "nginx_key_pair" {
  key_name   = "nginx-key"  
  public_key = file("~/.ssh/id_rsa.pub")  
}


## LB related resoures from AWS 

resource "aws_lb" "nginx_lb" {
  name               = "nginx-lb"
  internal           = false
  load_balancer_type = "application"

  enable_deletion_protection = false

  subnets      = var.subnet_ids
  enable_http2 = true

}

resource "aws_lb_listener" "nginx_listener_http" {
  load_balancer_arn = aws_lb.nginx_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = 200
      message_body = "Welcome to Nginx"
    }
  }
}

resource "aws_lb_target_group" "nginx_target_group" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-00917d332f96d91a5"

  health_check {
    path     = "/"
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "nginx_target_attachment" {
  target_group_arn = aws_lb_target_group.nginx_target_group.arn
  target_id        = aws_instance.nginx_instance.id
}

