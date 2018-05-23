# privacyhub.dev.asics.digital

locals {
  bucket_name = "static-asics-services-${var.env}-${data.aws_region.us-east-1.name}"
}

data "aws_s3_bucket" "bucket" {
  bucket = "${local.bucket_name}"
}

module "privacyhub" {
  source                                 = "github.com/FitnessKeeper/terraform-aws-s3-cloudfront?ref=v1.1.0"
  bucket_name                            = "${data.aws_s3_bucket.bucket.id}"
  create_bucket                          = false
  s3_region                              = "${data.aws_region.us-east-1.name}"
  cloudfront_fqdn                        = "${local.fqdn}"
  cloudfront_origin_path                 = "/${var.stack}"
  cloudfront_origin_access_identity_path = "${var.cloudfront_origin_access_identity_path}"
  cloudfront_price_class                 = "${var.price_class}"
  cloudfront_acm_cert_domain             = "${local.tld}"
  route53_toplevel_zone                  = "${local.tld}"
}
