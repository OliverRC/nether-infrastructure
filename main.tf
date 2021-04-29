terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.37.0"
    }
  }
  backend "s3" {
    bucket = "oli-testing-nether-terraform-state"
    key    = "nether"
    region = "af-south-1"
  }
}

provider "aws" {
  region = "af-south-1"
}

resource "aws_elastic_beanstalk_application" "nether-web" {
  name        = "nether-web"
  description = "Nether Website"
}

resource "aws_elastic_beanstalk_environment" "nether-web-env" {
  name                = "nether-web"
  application         = aws_elastic_beanstalk_application.nether-web.name
  solution_stack_name = "64bit Amazon Linux 2 v5.3.1 running Node.js 14"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
}