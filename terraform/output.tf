output "vpc_id" {
    value = aws_vpc.yusf.id

  
}

output "webserver" {
    value = aws_instance.webserver.public_ip

  
}

output "appserver" {
    value = aws_instance.appserver.id
  
}

output "url" {
    #value = format("http://%s/info.php",aws_instance.webserver.public_ip)
    value = format("http://%s/info.php",aws_instance.webserver.public_ip)
  
}