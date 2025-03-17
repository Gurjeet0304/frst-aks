# variable "environment" {
#     type = string

# }
variable "region" {
  type    = string
  default = "aue"

}
variable "service" {
  type    = string
  default = "frst"

}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
}

variable "address_space" {
  type    = string
  default = "aue"

}