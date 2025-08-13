resource "aws_db_subnet_group" "dbsubnetgroup" {
    name = local.db_subnet_group_name
    subnet_ids = [ aws_subnet.subnets[4].id, aws_subnet.subnets[5].id ]

    tags = {
        name = "ntiersubnet"
    }

    depends_on = [ 
        aws_subnet.subnets[4],
        aws_subnet.subnets[5]
     ]
  
}



resource "aws_db_instance" "yusufdb" {
    allocated_storage = 20
    allow_major_version_upgrade = false
    #allow_minor_version_upgrade = false
    backup_retention_period = 0
    engine = "mysql"
    engine_version = "8.0.41"
    instance_class = "db.t3.micro"
    identifier = "yusufdb"
    vpc_security_group_ids = [ aws_security_group.dbsg.id ]
    db_subnet_group_name = local.db_subnet_group_name
    skip_final_snapshot = true
    username = "admin12"
    password = "yusuf123"
    tags = {
      name = "yusufdb"
    }
    depends_on = [
         aws_db_subnet_group.dbsubnetgroup
     ]
  
}