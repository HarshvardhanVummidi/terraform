locals {
  subnets = [ "web1","web2","app1","app2","db1","db2" ]
  igw_name = "ntier_igw"
  anywhere = "0.0.0.0/0"
  ssh = 22
  http = 80
  appport = 8080
  dbport = 3306
  tcp  = "tcp"
  db_subnet_group_name = "ntierdbsubnet"
}