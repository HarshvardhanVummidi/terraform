/*provider "aws" {
    region = "us-east-1"

  
}
variable "ami" {

    description = "value"
    #type = string
    #default = "ami-053b0d53c279acc90"
  
}

variable "instance_type" {
    description = "value"
    type = map(string)
    default = {
      "dev" = "t2.micro"
      "stage" = "t2.medium"
      "prod" = "t2.xlarge"
    }
  
}

module "name" {
    source = "./modulesec2/ec2instance"
    ami = var.ami
    instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
  
}*/



provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "value"
}

variable "instance_type" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

module "ec2_instance" {
  source = "./modulesec2/ec2instance"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}
