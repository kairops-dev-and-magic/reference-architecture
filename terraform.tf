terraform {
  backend "azurerm" {
    storage_account_name = "tfstakskairospoc"
    container_name       = "terraform-state-kairos-poc"
    key                  = "test.terraform_state"
    access_key           = "secret"
  }
}
