resource "aws_acm_certificate_validation" "main" {
  provider = aws.us-east-1
  
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_validation : record.fqdn]
}