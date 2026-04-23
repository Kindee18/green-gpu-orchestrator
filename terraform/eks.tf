module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    gpu_nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 1

      instance_types = ["g4dn.xlarge"] # Cost-effective GPU instance
      ami_type       = "AL2_x86_64_GPU" # NVIDIA optimized AMI

      labels = {
        role = "gpu-worker"
      }
      
      taints = [{
        key    = "nvidia.com/gpu"
        value  = "true"
        effect = "NO_SCHEDULE"
      }]
    }
  }
}
