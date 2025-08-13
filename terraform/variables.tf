variable "region" {
    type = string
    default = "us-east-1"
    description = "region in which yusuf vpc has created"
  
}


variable "vpccidr" {
    type = string
    default = "192.168.0.0/16"
  
}

variable "webserverintancetype" {
    type = string
    default = "t2.micro"
  
}

/*variable "subnets" {
    type = list(string)
    default = [ "web1","web2","app1","app2","db1","db2" ]
  
} */

# 8 bits evvali 
/*variable "cidrranges" {
    type = list(string)
    default = [ "192.168.0.0/24","192.168.1.0/24","192.168.2.0/24","192.168.3.0/24","192.168.4.0/24","192.168.5.0/24" ]
  
} */

/*variable "subnetazs" {
    type = list(string)
    default = [ "us-east-1a","us-east-1b","us-east-1c","us-east-1a","us-east-1b","us-east-1c" ]
  
} */