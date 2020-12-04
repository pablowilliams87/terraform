provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

provider "helm" {}

provider "null" {}

####################
##  PREREQUISITOS:
##  - Instalar awscli
##  - Instalar kubectl
##
##  TODO: 
##  - Configurar version especifica de k8s
##
##  
##