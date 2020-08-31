
service = {
  namespace  = "microservices"
  name       = "bff-api"
  deployment = "bff-api-deployment"
  replicas   = 1
  image      = "yurikilian/bff-api"
  port       = 3000
}
