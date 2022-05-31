terraform {
  experiments = [module_variable_optional_attrs]
}

resource "kubernetes_deployment" "velocity" {
  count = var.proxy_type == "VELOCITY" ? 1 : 0
  metadata {
    name      = "velocity-proxy"
    namespace = var.namespace
  }
  spec {
    replicas = 1
    strategy {
      type = "Recreate"
    }

    selector {
      match_labels = {
        app = "mc-proxy"
      }
    }
    template {
      metadata {
        labels = {
          app = "mc-proxy"
        }
      }
      spec {
        container {
          image             = var.image
          name              = "mc-proxy"
          image_pull_policy = "Always"
          port {
            container_port = 25577
          }
          readiness_probe {
            tcp_socket {
              port = "25577"
            }
            initial_delay_seconds = "30"
            period_seconds        = "5"
            failure_threshold     = "10"
            success_threshold     = "1"
            timeout_seconds       = "1"
          }
          liveness_probe {
            tcp_socket {
              port = "25577"
            }
            initial_delay_seconds = "30"
            period_seconds        = "5"
            failure_threshold     = "10"
            success_threshold     = "1"
            timeout_seconds       = "1"
          }
          resources {
            limits = {
              cpu    = var.cpu_limit
              memory = var.mem_limit
            }
            requests = {
              cpu    = "200m"
              memory = "256M"
            }
          }
          env {
            name  = "TYPE"
            value = "VELOCITY"
          }
          volume_mount {
            name       = "velocity-proxy-volume"
            mount_path = "/config"
          }
        }
        volume {
          name = "velocity-proxy-volume"
          config_map {
            name = "velocity-proxy-configmap"
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "proxy" {
  count = (var.proxy_type == "WATERFALL" || var.proxy_type == "BUNGEECORD") ? 1 : 0
  metadata {
    name      = "${lower(var.proxy_type)}-proxy"
    namespace = var.namespace
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mc-proxy"
      }
    }
    template {
      metadata {
        labels = {
          app = "mc-proxy"
        }
      }
      spec {
        container {
          image             = var.image
          name              = "mc-proxy"
          image_pull_policy = "Always"
          port {
            container_port = 25577
          }
          readiness_probe {
            tcp_socket {
              port = "25577"
            }
            initial_delay_seconds = "30"
            period_seconds        = "5"
            failure_threshold     = "10"
            success_threshold     = "1"
            timeout_seconds       = "1"
          }
          liveness_probe {
            tcp_socket {
              port = "25577"
            }
            initial_delay_seconds = "30"
            period_seconds        = "5"
            failure_threshold     = "10"
            success_threshold     = "1"
            timeout_seconds       = "1"
          }
          resources {
            limits = {
              cpu    = var.cpu_limit
              memory = var.mem_limit
            }
          }
          env {
            name  = "TYPE"
            value = var.proxy_type
          }
          volume_mount {
            name       = "waterfall-proxy-volume"
            mount_path = "/config"
          }
        }
        volume {
          name = "waterfall-proxy-volume"
          config_map {
            name = "bungee-waterfall-proxy-configmap"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "proxy" {
  metadata {
    name      = "mc-proxy"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "mc-proxy"
    }
    type = "LoadBalancer"
    port {
      port        = var.proxy_port
      target_port = 25577
    }
  }
}
