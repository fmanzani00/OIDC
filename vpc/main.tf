resource "aws_vpc" "this" {
  cidr_block          = var.use_ipam_pool ? null : var.cidr
  ipv4_ipam_pool_id   = var.ipv4_ipam_pool_id
  ipv4_netmask_length = var.ipv4_netmask_length

  assign_generated_ipv6_cidr_block     = var.enable_ipv6 && !var.use_ipam_pool ? true : null
  ipv6_cidr_block                      = var.ipv6_ipam_pool_id != null ? var.ipv6_cidr : null
  ipv6_ipam_pool_id                    = var.ipv6_ipam_pool_id
  ipv6_netmask_length                  = var.ipv6_netmask_length
  ipv6_cidr_block_network_border_group = var.ipv6_cidr_block_network_border_group

  instance_tenancy                     = var.instance_tenancy
  enable_dns_hostnames                 = var.enable_dns_hostnames
  enable_dns_support                   = var.enable_dns_support
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}

resource "aws_vpc_ipv4_cidr_block_association" "default" {
  for_each =  var.enable_ipv4_block ? var.ipv4_additional_cidr_block_associations : {}

  cidr_block          = each.value.ipv4_cidr_block
  ipv4_ipam_pool_id   = each.value.ipv4_ipam_pool_id
  ipv4_netmask_length = each.value.ipv4_netmask_length

  vpc_id = aws_vpc.this.id

  dynamic "timeouts" {
    for_each = var.ipv4_cidr_block_association_timeouts != null ? [true] : []
    content {
      create = lookup(var.ipv4_cidr_block_association_timeouts, "create", null)
      delete = lookup(var.ipv4_cidr_block_association_timeouts, "delete", null)
    }
  }
}

resource "aws_vpc_ipv6_cidr_block_association" "default" {
  for_each = var.enable_ipv6_block ? var.ipv6_additional_cidr_block_associations : {}

  ipv6_cidr_block     = each.value.ipv6_cidr_block
  ipv6_ipam_pool_id   = each.value.ipv6_ipam_pool_id
  ipv6_netmask_length = each.value.ipv6_netmask_length

  vpc_id = aws_vpc.this.id

  dynamic "timeouts" {
    for_each = var.ipv6_cidr_block_association_timeouts != null ? [true] : []
    content {
      create = lookup(var.ipv6_cidr_block_association_timeouts, "create", null)
      delete = lookup(var.ipv6_cidr_block_association_timeouts, "delete", null)
    }
  }
}

#  ---------------------------- VPC ENDPOINT  ---------------------------- 

resource "aws_vpc_endpoint" "this" {
  vpc_id            = aws_vpc.this.id
  service_name      = var.service_name
  vpc_endpoint_type = var.vpc_endpoint_type

  dynamic "subnet_configuration" {
    for_each = var.subnet_configurations
    content {
      ipv4      = subnet_configuration.value.ipv4
      subnet_id = subnet_configuration.value.subnet_id
    }
  }

  subnet_ids = var.subnet_ids
}