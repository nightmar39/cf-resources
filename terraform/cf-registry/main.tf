terraform {
  required_providers {
    codefresh = {
      source = "codefresh-io/codefresh"
      version = "0.0.20"
    }
  }
}

variable api_url {
  type = string
  default = ""
}

variable token {
  type    = string
  default = ""
}

variable docker_username {
  type = string
}

variable docker_token {
  type = string  
}

provider "codefresh" {
  api_url = var.api_url
  token   = var.token
}

data "codefresh_registry" "nightmar39" {
  name = "nightmar39"
}

resource "codefresh_registry" "dockerhub1" {
  name = "dockerhub1"
  primary = false 
  spec {
    dockerhub {
      username = var.docker_username
      password = var.docker_token
    }
  }
  fallback_registry = data.codefresh_registry.dockerhub1.id
}
