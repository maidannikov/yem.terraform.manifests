resource "github_repository" "GH_WF_CLEANUP" {
  allow_auto_merge            = false
  allow_merge_commit          = true
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_update_branch         = false
  archived                    = false
  auto_init                   = true
  delete_branch_on_merge      = true
  description                 = "Azure VM cleanup"
  has_discussions             = false
  has_downloads               = true
  has_issues                  = true
  has_projects                = true
  has_wiki                    = true
  is_template                 = false
  merge_commit_message        = "PR_TITLE"
  merge_commit_title          = "MERGE_MESSAGE"
  name                        = "yem.workflow.vmcleanup"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  topics                      = []
  visibility                  = "public"
  vulnerability_alerts        = false
  security_and_analysis {
    secret_scanning {
      status = "disabled"
    }
    secret_scanning_push_protection {
      status = "disabled"
    }
  }
}

resource "github_branch" "master_wf_cleanup" {
  repository = github_repository.GH_WF_CLEANUP.name
  branch     = "master"
}

resource "github_branch_default" "default_wf_cleanup"{
  repository = github_repository.GH_WF_CLEANUP.name
  branch     = github_branch.master_wf_cleanup.branch
}