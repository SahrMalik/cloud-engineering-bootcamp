public_subnets = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
azs = ["eu-west-2a","eu-west-2b","eu-west-2c"]

instance_type = "t2.micro"

desired_capacity = 1
max_size = 2
min_size = 1

/*Launch templates are created in a seperate directory. The templates require 
security group ID's, I'm unsure as to how to give the templates security group ID's
when the vpc and SG's are created upon each terraform apply */
