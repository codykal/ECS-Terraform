data "aws_route53_zone" "Topdomain-zone" {
    name = "codykall.com"
}


resource "aws_route53_record" "metabase-subdomain" {
  zone_id = data.aws_route53_zone.Topdomain-zone.zone_id
  name = "metabase.codykall.com"
  type = "A"

  alias {
    name = aws_lb.LoadBalancer.dns_name
    zone_id = aws_lb.LoadBalancer.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "myphpadmin-subdomain" {
  zone_id = data.aws_route53_zone.Topdomain-zone.zone_id
  name = "myphpadmin.codykall.com"
  type = "A"

  alias {
    name = aws_lb.LoadBalancer.dns_name
    zone_id = aws_lb.LoadBalancer.zone_id
    evaluate_target_health = true
  }
}