provider "aws" {
  version = "~> 2.54"
  region = "us-west-2"
}

provider "local" {
  version = "~> 1.4"
}

provider "random" {
  version = "~> 2.2"
}

provider "tls" {
  version = "~> 2.1"
}
