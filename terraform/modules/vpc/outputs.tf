### OUTPUTS VPC

output "module_public_subnets" {
  value = module.vpc.public_subnets[*]
}

output "module_vpc_security_group_ids" {
  value = module.vpc.default_security_group_id
}

output "module_private_subnets" {
  value = module.vpc.private_subnets[*]
}