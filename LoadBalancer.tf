resource "aws_lb" "LoadBalancer" {
  name               = "LoadBalancer"
  internal           = false
  load_balancer_type = "application"
  drop_invalid_header_fields = true
  security_groups    = [aws_security_group.ALB-SG.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
}

resource "aws_lb_target_group" "ALB-TG-myphpadmin" {
  name     = "ALB-TG-myphpadmin"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.ECSProject-VPC.id

}

resource "aws_lb_target_group" "ALB-TG-metabase" {
  name     = "ALB-TG-metabase"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.ECSProject-VPC.id

}

resource "aws_lb_listener" "https-listener" {
  load_balancer_arn = aws_lb.LoadBalancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = data.aws_acm_certificate.Wildcard-Cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ALB-TG-myphpadmin.arn
  }

}

resource "aws_lb_listener_rule" "metabase-rule" {
  listener_arn = aws_lb_listener.https-listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ALB-TG-metabase.arn
  }

  condition {
    host_header {
      values = ["metabase.codykall.com"]
    }
  }
}

resource "aws_lb_listener_rule" "myphpadmin-rule" {
  listener_arn = aws_lb_listener.https-listener.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ALB-TG-myphpadmin.arn
  }

  condition {
    host_header {
      values = ["myphpadmin.codykall.com"]
    }
  }
}