# packer 블록에는 필수 packer 버전 및 설정 정의
packer  {
  required_plugins {
    comment = {
      source = "github.com/sylviamoss/comment"
      version = ">= 0.2.24"
    }
  }
}


# source 블록에는 실제 빌드할 이미지에 대한 스펙을 정의
locals {
 timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}
source "amazon-ebs" "al2023" {
  ami_name      = "al2023-packertest-${local.timestamp}"
  vpc_id =  "vpc-02362e7d165fbaacf"
  security_group_id =  "sg-098bb324e219c479b"

subnet_id = "subnet-099b77f5d87629a82"
  instance_type = "t2.micro"
  region        = "ap-northeast-2"
  source_ami_filter {
    filters = {
      image-id            = "ami-0e01e66dacaf1454d"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["137112412989"]
  }
  ssh_username = "ec2-user"
  ssh_keypair_name = "1024test"
  ssh_private_key_file = "/root/packertest/1024test.pem"
}

#환경 변수 세팅
build {
  name = "accordion-packer"
  sources = [
    "source.amazon-ebs.al2023"
  ]

 provisioner "shell" {
    execute_command = "sudo -S -E bash '{{ .Path }}'"
    scripts = [
      "${path.root}/setup.sh",
    ]
  }
}