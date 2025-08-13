terraform {
  backend "s3" {
    bucket = "yusuf-beig-harsh2"
    #key = "C:/Users/harsh/Downloads/terraform/terraform.tfstate"
    key = "environments/C:/Users/harsh/Downloads/terraform/terraform.tfstate"
    #key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraformlocks"
    /*workspaces {
          prefix = "lt-eapp-"
    }*/
  }
}