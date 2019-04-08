terraform {
  backend "azurerm" {
    storage_account_name = "tfstakskairospoc"
    container_name       = "terraform-state-kairos-poc"
    key                  = "test.terraform_state"
    access_key           = "+NSOMFYpIdtbiUKAqXK/vZGptVXEEde7K5feCXb7Tq2zARh+B94gmAbPCMuU6DjkNJ0tlEklhcJbcIJcyJx7jA=="
  }
}

