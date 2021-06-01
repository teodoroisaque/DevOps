provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "ubuntu" {
  most_recent            = true

  filter {
    name                 = "name"
    values               = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners                 = ["099720109477"] # Canonical
}

resource "aws_key_pair" "key_ssh" {
  key_name               = "isaque_ssh_pub"
  public_key             = "<imput_ssh_key_PUB>"
}

module "vpc" {
  source                 = "./modules/vpc"
  infra_env              = "staging"
  vpc_cidr               = "10.0.0.0/17"
  azs                    = ["us-east-2a", "us-east-2b", "us-east-2c"]
  public_subnets         = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets        = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "ec2-private-a" {
  source                 = "./modules/ec2"
  number_servers         = 0
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.module_vpc_security_group_ids]
  subnet_id              = module.vpc.module_private_subnets[0]
  key_name               = "isaque_ssh_pub"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}

module "ec2-private-b" {
  source                 = "./modules/ec2"
  number_servers         = 0
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.module_vpc_security_group_ids]
  subnet_id              = module.vpc.module_private_subnets[1]
  key_name               = "isaque_ssh_pub"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}

module "ec2-private-c" {
  source                 = "./modules/ec2"
  number_servers         = 0
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.module_vpc_security_group_ids]
  subnet_id              = module.vpc.module_private_subnets[2]
  key_name               = "isaque_ssh_pub"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}

module "ec2-public-a" {
  source                 = "./modules/ec2"
  number_servers         = 0
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.module_vpc_security_group_ids]
  subnet_id              = module.vpc.module_public_subnets[0]
  key_name               = "isaque_ssh_pub"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}

module "ec2-public-b" {
  source                 = "./modules/ec2"
  number_servers         = 0
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.module_vpc_security_group_ids]
  subnet_id              = module.vpc.module_public_subnets[1]
  key_name               = "isaque_ssh_pub"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}

module "ec2-public-c" {
  source                 = "./modules/ec2"
  number_servers         = 0
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.module_vpc_security_group_ids]
  subnet_id              = module.vpc.module_public_subnets[2]
  key_name               = "isaque_ssh_pub"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}