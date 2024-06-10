###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

### SA variable
variable "sa_name" {
  type        = string
  default     = "project-sa"
  description = "serviceAccount name"
}

variable "key_name" {
  type        = string
  default     = "project_key"
  description = "key for sa name"
}


### Bucket variable
variable "bucket_name" {
  type        = string
  default     = "projectbucketdiplom"
  description = "S3 bucket name"
}


### VPC variable
variable "vpc_name" {
  type        = string
  default     = "project"
  description = "VPC network name"
}

variable "subnet_name" {
 type        = list(string)
 description = "Subnet name values"
 default     = ["main-a", "main-b", "main-c"]
}

variable "subnet_cidrs" {
 type        = list(string)
 description = "Subnet CIDR values"
 default     = ["10.0.100.0/24", "10.0.150.0/24", "10.0.200.0/24"]
}

variable "zone" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}


### compute instance variable
variable "vm-control-node" {
    type = map(number)
    default = {
        cores = 4
        memory = 8
        core_fraction = 100
    }
}

variable "vm-worker-node" {
    type = map(number)
    default = {
        cores = 4
        memory = 4
        core_fraction = 20
    }
}

variable "num_node" {
 type        = list(string)
 description = "number of control and worker nodes"
 default     = ["vm-control-node", "vm-worker-node-1", "vm-worker-node-2"]
}

variable "image_family" {
  type        = string
  default     = "centos-7"
  description = "yandex compute image family"}