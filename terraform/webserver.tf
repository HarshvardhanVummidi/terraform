resource "aws_instance" "webserver" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.webserverintancetype
    vpc_security_group_ids = [ aws_security_group.websg.id ]
    subnet_id = aws_subnet.subnets[0].id
    associate_public_ip_address = true
    key_name = "terraform"
    tags = {
      name = "webserver"
    }

    /*connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("C:/Users/harsh/Downloads/terraform.pem") #file("C:\Users\harsh\Downloads\terraform.pem")
      # file function is used to locate the file
      host = self.public_ip
      # or we can use this if we write connection from another blockhost = aws_instance.webserver.public-ip


    }

    provisioner "remote-exec" {
      inline = [ "sudo apt update", "sudo apt install apache2 -y" ]
      
    }*/
    # now we will write null resource in below block to ignore tainting everytime using of null resource the resource will execute but it wont create everytime

    depends_on = [ aws_db_instance.yusufdb ]

  
}

resource "null_resource" "nullprovisioning" {


    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("C:/Users/harsh/Downloads/terraform.pem") #file("C:\Users\harsh\Downloads\terraform.pem")
      # file function is used to locate the file
      host = aws_instance.webserver.public_ip
      # or we can use this if we write connection from another blockhost = aws_instance.webserver.public-ip


    }

    provisioner "remote-exec" {
      inline = [ "sudo apt update", 
      "sudo apt install apache2 -y",
      "sudo apt install php libapache2-mod-php php-mysql php-cli -y",
        "echo '<?php phpinfo(); ?>'| sudo tee /var/www/html/info.php" ]
      
    }

  
}

resource "aws_instance" "appserver" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.webserverintancetype
    vpc_security_group_ids = [ aws_security_group.appsg.id ]
    subnet_id = aws_subnet.subnets[2].id
    associate_public_ip_address = false 
    key_name = "terraform"
    tags = {
      name = "appserver"
    }

    
  
}