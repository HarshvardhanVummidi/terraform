
# created vpc
resource "aws_vpc" "yusf" {
    cidr_block = var.vpccidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name = "${terraform.workspace}-vpc"
      Terraform = "true"
      Environment = terraform.workspace
    }
  
}
# created S3 bucket
resource "aws_s3_bucket" "mybucket" {
    bucket = "yusuf-beig-harsh2"
  
}

# Lets create a subnet web1

resource "aws_subnet" "subnets" {
    count = 6
    vpc_id = aws_vpc.yusf.id
    cidr_block = cidrsubnet(var.vpccidr, 8, count.index)
    
    /*cidr_block = var.cidrranges[count.index]*/

    #availability_zone = var.subnetazs[count.index]
    availability_zone = "${var.region}${count.index %2== 0?"a":"b"}"

    tags = {
        Name = local.subnets[count.index]
      
    }
    depends_on = [ 
        aws_vpc.yusf
         ]
  
}

# Lets create a subnet web1

# Lets create a Internetgateway
resource "aws_internet_gateway" "ntierigw" {
    vpc_id = aws_vpc.yusf.id
    tags = {
        Name = local.igw_name
    }
    depends_on = [
        aws_vpc.yusf
     ]
  
}

# Lets create routetables

resource "aws_route_table" "publicrt" {
    vpc_id = aws_vpc.yusf.id
    route {
        cidr_block = local.anywhere
        gateway_id = aws_internet_gateway.ntierigw.id


    }
    
    depends_on = [ 
        aws_vpc.yusf,
        aws_subnet.subnets[0],
        aws_subnet.subnets[1]
     ]


    tags = {
      Name = "publicrt"
    }
  
}

# Lets create Route table ssociations
resource "aws_route_table_association" "webassociations" {
    count = 2
    subnet_id = aws_subnet.subnets[count.index].id
    route_table_id = aws_route_table.publicrt.id

    depends_on = [ 
        aws_route_table.publicrt
     ]
  
}

resource "aws_route_table" "privatert" {
    vpc_id = aws_vpc.yusf.id
    tags = {
      Name = "privatert"
    }

    depends_on = [ 
        aws_vpc.yusf,
        aws_subnet.subnets[2],
        aws_subnet.subnets[3],
        aws_subnet.subnets[4],
        aws_subnet.subnets[5]
     ]
  
}


resource "aws_route_table_association" "appassociations" {
    count = 4
    route_table_id = aws_route_table.privatert.id
    subnet_id = aws_subnet.subnets[count.index + 2].id
    depends_on = [ 
        aws_route_table.privatert
     ]
  
}
/*resource "aws_route_table_association" "webassociation2" {
    subnet_id = aws_subnet.subnets[1].id
    route_table_id = aws_route_table.publicrt.id
  
} */


# create security groups

resource "aws_security_group" "websg" {
    name = "websg"
    description = " Allow ssh and http from all"
    vpc_id = aws_vpc.yusf.id

    ingress  {
        cidr_blocks = [local.anywhere]
        from_port = local.ssh
        protocol = local.tcp
        to_port = local.ssh
    }

    ingress  {
        cidr_blocks = [local.anywhere]
        from_port = local.http
        protocol = "tcp"
        to_port = local.http
    }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
    }




    tags = {
      Name = "websg"
    }
  
  
}


resource "aws_security_group" "appsg" {
    name = "appsg"
    vpc_id = aws_vpc.yusf.id
    description = "open 8080 and 22 port with in vpc range"


    ingress {
        cidr_blocks = [ var.vpccidr ]
        from_port = local.ssh
        protocol = local.tcp
        to_port = local.ssh

    }

    ingress {
        cidr_blocks = [ var.vpccidr ]
        from_port = local.appport
        protocol = local.tcp
        to_port = local.appport
    }


    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
      name = "appsg"
    }
  
}

resource "aws_security_group" "dbsg" {
    name = "dbsg"
    vpc_id = aws_vpc.yusf.id
    description = "open port 3306 within vpc "


    ingress {
        cidr_blocks = [ var.vpccidr ]
        from_port = local.dbport
        protocol = local.tcp
        to_port = local.dbport
    }

 
    tags = {
      Name = "appsg"
    }
  
}


