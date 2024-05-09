variable "LINUX" { # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  type = map(any)
  default = {
    us-east-1 = "ami-04e5276ebb8451442"
    us-east-2 = "ami-080e449218d4434fa"
  }

}

variable "UBUNTU" { # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
  type = map(any)
  default = {
    us-east-1 = "ami-080e1f13689e07408"
    us-east-2 = "ami-0b8b44ec9a8f90422"
  }

}

variable "WINDOWS" { # Microsoft Windows Server 2022 Base
  type = map(any)
  default = {
    us-east-1 = "ami-0f496107db66676ff"
    us-east-2 = "ami-0caa6784ed30b62c4"
  }

}


variable "KEY" {
  type = map(any)
  default = {
    us-east-1 = "keypair"
    us-east-2 = "east2-key"
  }

}