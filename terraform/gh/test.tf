resource "github_repository" "tf-acc-test" {
  name      = "tf-acc-test"
  auto_init = true
}

resource "github_repository_file" "foo" {
  repository          = github_repository.tf-acc-test.name
  branch              = "main"
  file                = ".gitignore"
  content             = "**/*.tfstate"
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

resource "github_repository_file" "foo2" {
  repository          = github_repository.tf-acc-test.name
  branch              = "main"
  file                = ".gitignore2"
  content             = "**/*.tfstate"
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}
