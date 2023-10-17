variable "GOOGLE_APPLICATION_CREDENTIALS" {
  description = "GCP json file"
  type        = string
  sensitive   = true
}
variable "TBotTOKEN" {
  description = "Token for telegram bot"
  type        = string
  sensitive   = true
}
variable "GCPSSHKEYPUB" {
  description = "Public SSH key"
  type        = string
  sensitive   = true
}

variable "GCPSSHKEY" {
  description = "Private SSH key"
  type        = string
  sensitive   = true
}

variable "github_token" {
  description = "token to gh"
  type        = string
  sensitive   = true
}

variable "github_owner" {
  description = "name of gh owner"
  type        = string
  sensitive   = false
}

variable "github_repo" {
  description = "name of gh repo"
  type        = string
  sensitive   = false
}
