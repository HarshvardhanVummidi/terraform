resource "aws_instance" "exampleinstance" {
    ami = var.ami
    instance_type = var.instance_type
  
}
variable "ami" {
    description = "This is the instance type"
  
}
variable "instance_type" {
    description = "This is AMI for the instance"
  
}