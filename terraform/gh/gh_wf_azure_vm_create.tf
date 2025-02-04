resource "github_repository" "GH_WF_CREATE" {
  name                   = "yem.workflow.azurevmghrunner"
  description            = "GitHub Self-Hosted Runner on Azure"
  visibility             = "public"
  allow_auto_merge       = false
  allow_merge_commit     = true
  allow_rebase_merge     = true
  allow_squash_merge     = true
  delete_branch_on_merge = true
  auto_init              = true
  has_issues             = true
  has_projects           = true
  has_wiki               = true
  archived               = false
  vulnerability_alerts   = false
  security_and_analysis {
    secret_scanning {
      status = "disabled"
    }
    secret_scanning_push_protection {
      status = "disabled"
    }
  }
}

resource "github_branch" "master_wf_create" {
  repository = github_repository.GH_WF_CREATE.name
  branch     = "master"
}

resource "github_branch_default" "default_wf_create" {
  repository = github_repository.GH_WF_CREATE.name
  branch     = github_branch.master_wf_create.branch
}

resource "github_branch" "dev_wf_create" {
  repository    = github_repository.GH_WF_CREATE.name
  branch        = "dev"
  source_branch = github_branch.master_wf_create.branch
}

resource "null_resource" "delete_main_branch" {
  provisioner "local-exec" {
    command = <<EOT
      curl -X DELETE \
      -H "Authorization: token ${var.github_token}" \
      -H "Accept: application/vnd.github.v3+json" \
      https://api.github.com/repos/${var.github_owner}/${github_repository.GH_WF_CREATE.name}/git/refs/heads/main
    EOT
  }

  depends_on = [github_branch.dev_wf_create]
}