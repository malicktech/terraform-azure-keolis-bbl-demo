variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
}

/* Mysql server */

variable "mysql_administrator_login" {
  type        = string
  description = "MySql master login"
}

variable "mysql_administrator_login_password" {
  type        = string
  description = "MySql master password"
}

/* Docker app */ 

variable "docker_image" {
  description = "Docker image name"
}

variable "docker_image_tag" {
  description = "Docker image tag"
}

/* Others */
variable "firewall_ip_address" {
  description = "Ip address to allow on databse firewal"
}
