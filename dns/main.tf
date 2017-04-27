/**
 * The dns module creates a local route53 zone that serves
 * as a service discovery utility. For example a service
 * resource with the name `auth` and a dns module
 * with the name `stack.local`, the service address will be `auth.stack.local`.
 *
 * Usage:
 *
 *    module "dns" {
 *      source = "github.com/segment/stack"
 *      name   = "stack.local"
 *    }
 *
 */

variable "name" {
  description = "Zone name, e.g stack.local"
}

variable "vpc_id" {
  description = "The VPC ID (omit to create a public zone)"
  default     = ""
}

variable "zone_id" {
  description = "The Zone ID (omit to create a new zone)"
  default     = ""
}

resource "aws_route53_zone" "main" {
  name    = "${var.name}"
  vpc_id  = "${var.vpc_id}"
  zone_id = "${var.zone_id}"
  comment = ""
}

// The domain name.
output "name" {
  value = "${var.name}"
}

// The zone ID.
output "zone_id" {
  value = "${aws_route53_zone.main.zone_id}"
}

// A comma separated list of the zone name servers.
output "name_servers" {
  value = "${join(",",aws_route53_zone.main.name_servers)}"
}
