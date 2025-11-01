#
# This template file exposes only the most common parameters.
# Please check the variables.tf file for all supported parameters and their details.
#

# ========================= CLOUD RESOURCES IDENTIFICATION =============================================================
environment_prefix = "itom-toolkit"
tags               = {
  "Owner" = ""
}

# ========================= NETWORK CONFIGURATION ======================================================================
allowed_client_cidrs = ["0.0.0.0/0"]      # Who can access the suite services?

# ========================= KUBERNETES CLUSTER CONFIGURATION ===========================================================
node_instance_type        = "m5.large"      # What's the instance type for the Kubernetes worker nodes?
node_group_desired_size   = 3                 # How many nodes are needed (up to 10 or check variables.tf for more options)?
k8s_version = "1.33"
enable_kms_encryption_eks = false             #Set to true to enable secrets encryption for eks with kms key. Enabling this will create a kms key with rotation policy of 1 year

# ========================= RDS DATABASE CONFIGURATION =================================================================
database_engine         = "postgres"        # What RDS database to deploy? Supported values: postgres, oracle-ee
database_engine_version = "16.6"           # Which version of the database is needed?
database_instance_type  = "db.t3.small"    # What's the database instance type? Consult: https://aws.amazon.com/rds/instance-types/
database_volume_size    = 100               # How much storage (GiB) should the database use?

# Create a DB and set credentials for the master DB user
database_name           = "toolkit"
database_admin_username = "dbadmin"
database_admin_password = "Gsnimanager1!"    # 8-128 characters, combination of letters, digits, and special characters # ? = _ ) ! , ~ : % ; ^ + . - & < [ | * / $  ( > ] { }

# Create a custom Database Parameter Group for the RDS Postgres DB
# By default is skipped and will use the AWS default DB parameter group associated to the Postgres DB family
# If true, please check the supported parameters in the "ADVANCED CONFIGURATION FOR RDS POSTGRES DATABASE" section of variables.tf file
create_postgres_parameter_group = false

# ========================= VERTICA DATABASE CONFIGURATION =============================================================
# IMPORTANT: To skip Vertica deployment add the following parameter: skip_vertica_deployment = true
# Please check "ADVANCED VERTICA CONFIGURATION" section of variables.tf file for advanced tuning options
#skip_vertica_deployment = true

#Multi AZ configuration
workers_multi_az = false                #Place worker nodes on multiple availability zones
# Enable 'workers_multi_az' capability to consider the below number of AZs for EKS, otherwise the default is always 2
number_eks_azs   = 2                  #Number of availability zones to use for EKS. Please check maximum number of AZs for your region first.

vpc_cidr_block = "10.0.0.0/16"  # CIDR block to be used for VPC. If you are using your existing VPC, update this variable with the CIDR range of your existing VPC

#vertica_mc_for_monitoring = false     # Set to true if you want vertica mc console for monitoring purpose with vertica 24.x version.

# ========================= EXISTING VPC CONFIGURATION =============================================================

#CIDRs of subnets you pass below should be within the above provided range of 'vpc_cidr_block'

use_existing_vpc                   = false  # Set this to true if you want to use your existing VPC and network configuration. Below parameters are applicable if this is set to true
existing_vpc_id                    = "null" # ID of your existing VPC
existing_private_rds_subnet_ids    = []     # IDs of two private subnets for RDS
existing_private_vertica_subnet_id = "null" # ID of one private subnet for vertica
existing_nat_gw_eip                = "null" # Public Elastic IP attached to the NAT gateway
existing_public_subnet_ids         = []     # IDs of all the public subnets. If 'workers_multi_az' variable is set to false, pass 2 subnet IDs.If 'workers_multi_az' variable is set to true, the number of subnet IDs should be equal to the value set for 'number_eks_azs'
existing_private_eks_subnet_ids    = []     # IDs of all the private subnets for eks. If 'workers_multi_az' variable is set to false, pass 2 subnet IDs.If 'workers_multi_az' variable is set to true, the number of subnet IDs should be equal to the value set for 'number_eks_azs'
#For example, when 'workers_multi_az' is set to true and 'number_eks_azs' is set to 4, pass 4 subnet IDs for both 'existing_public_subnet_ids' and 'existing_private_eks_subnet_ids'
