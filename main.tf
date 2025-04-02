terraform {
  backend "s3" {
    bucket         = "s3-tfstate-oidc"  # Nombre del bucket S3
    key            = "terraform.tfstate"  # Ruta del archivo de estado en S3
    region         = "eu-west-1"          # Región del bucket S3
    dynamodb_table = "terraform-lock"     # Nombre de la tabla de DynamoDB para bloqueo
  }
}

module "vpc" {
  source = "./vpc"

  name = "vpc-git"
  cidr = "110.0.0.0/16"

  service_name = "com.amazonaws.eu-west-1.ec2"
}
