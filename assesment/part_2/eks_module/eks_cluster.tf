variable "subnet_ids" {
  
}

variable "vpc_id" {
  
}

#variable "security_group_ids" {}

variable "cluster_name" {
  type = string
  default = "test"
}

variable "cluster_version" {
  default = "1.29"
  type = string
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access  = true
  
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  control_plane_subnet_ids = var.subnet_ids

    # Self Managed Node Group(s)
    self_managed_node_group_defaults = {
        instance_type                          = "m2.micro"
        update_launch_template_default_version = true
        iam_role_additional_policies = {
        AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
        }
    }


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    attach_cluster_primary_security_group = true
    #vpc_security_group_ids                = var.security_group_ids
    instance_types = ["t2.micro"]
    ami_type = "BOTTLEROCKET_x86_64"
    min_size     = 2
    max_size     = 2
    desired_size = 2
    }
  eks_managed_node_groups = {
    green = {
    attach_cluster_primary_security_group = true
    #vpc_security_group_ids                = var.security_group_ids
    instance_types = ["t2.micro"]
    ami_type = "BOTTLEROCKET_x86_64"
    min_size     = 2
    max_size     = 2
    desired_size = 2

      instance_types = ["t2.micro"]
      capacity_type  = "SPOT"
      labels = {
        Environment = "test"
        GithubRepo  = "terraform-aws-eks"
        GithubOrg   = "terraform-aws-modules"
      }


      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 100
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 150
            delete_on_termination = true
          }
        }
      }

      update_config = {
        max_unavailable_percentage = 33 # or set `max_unavailable`
      }

    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

