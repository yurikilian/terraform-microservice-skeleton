
variable "service" {
  type = object({
    namespace  = string
    name       = string
    deployment = string
    replicas   = number
    image      = string
    port       = number
  })
}
