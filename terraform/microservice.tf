provider "kubernetes" {
  config_context = "minikube"
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.service.namespace
  }
}


resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = var.service.deployment
    namespace = var.service.namespace
  }

  spec {
    replicas = var.service.replicas


    selector {
      match_labels = {
        appName = var.service.name
      }
    }

    template {
      metadata {
        labels = {
          appName = var.service.name
        }
      }
      spec {
        container {
          image = var.service.image
          name  = "${var.service.name}-container"


          liveness_probe {
            http_get {
              path = "/healthcheck"
              port = var.service.port
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "service" {
  metadata {
    name      = var.service.name
    namespace = var.service.namespace
  }

  spec {
    selector = {
      appName = var.service.name
    }

    port {
      port        = var.service.port
      target_port = var.service.port
    }

    #type = "NodePort"
  }

}




resource "kubernetes_ingress" "ingress" {
  metadata {
    name      = "bff-api-ingress"
    namespace = var.service.namespace
  }

  spec {
    backend {
      service_name = var.service.name
      service_port = var.service.port
    }

    rule {
      http {
        path {
          backend {
            service_name = var.service.name
            service_port = var.service.port
          }

          path = "/"

        }
      }
    }

  }
}


