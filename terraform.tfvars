vpc_cidr = "10.0.0.0/16"
public_subnet_cidr = [ "10.0.1.0/24","10.0.2.0/24","10.0.3.0/24" ]
private_subnet_cidr = [ "10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
region = "ap-south-1"
availability_zones = [ "ap-south-1a","ap-south-1b","ap-south-1c" ]
EKS-CLUSTER-NAME = "maruthi-eks-cluster"
EKS-Cluster-Version = "1.30"
node_group = {
  "default" = {
     instance_types = ["t2.medium"]
     capacity_type = "ON_DEMAND"
     scaling_config = {
      desired_size = 2
      max_size = 3
      min_size = 1
  }
}

}
