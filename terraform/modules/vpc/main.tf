module "vpc" {
    source                  = "terraform-aws-modules/vpc/aws"
    version                 = "2.77.0"

    name                    = "esx-${var.infra_env}-vpc"
    cidr                    = var.vpc_cidr
    azs                     = var.azs

    enable_nat_gateway      = true
    single_nat_gateway      = true
    one_nat_gateway_per_az  = false

    private_subnets         = var.private_subnets
    public_subnets          = var.public_subnets
    
    tags = {
        Name                = "esx-${var.infra_env}-vpc"
        Project             = "esx-teste"
        Environment         = "${var.infra_env}"
    }
}