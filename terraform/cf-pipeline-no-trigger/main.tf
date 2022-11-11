terraform {
  required_providers {
    codefresh = {
      source = "codefresh-io/codefresh"
      version = "0.0.20"
    }
  }
}

provider "codefresh" {
  api_url = "https://g.codefresh.io/api"
  token   = "617cca8ae32e95bc27081a64.5f0555ff31ed425abe391aff2531112b"
}

resource "codefresh_project" "first_proj" {
  name = "terraform_project"
}

resource "codefresh_pipeline" "first_pipe" {

  lifecycle {
    ignore_changes = [
      revision
    ]
  }

  name = "${codefresh_project.first_proj.name}/terraform-trigger-test"

  tags = [
    "terraform",
    "test",
  ]

  spec {
    concurrency         = 1
    branch_concurrency  = 1
    trigger_concurrency = 1

    priority    = 5

    spec_template {
      repo        = "nightmar39/manifests"
      path        = "codefresh.yaml"
      revision    = "main"
      context     = "github"
    }


    termination_policy {
      on_terminate_annotation = false
      on_create_branch {
        ignore_trigger = false 
      } 
    }

  }
}