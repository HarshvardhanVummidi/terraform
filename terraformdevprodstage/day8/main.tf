provider "aws" {
    region = "us-east-1"
  
}
import {
  id = "i-0d7539b2a91b90f99"

  to = aws_instance.example
}