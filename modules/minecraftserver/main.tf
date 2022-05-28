terraform {
  experiments = [module_variable_optional_attrs]
}

resource "kubernetes_deployment" "_" {
  metadata {
    name      = var.server_name
    namespace = var.namespace
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "minecraft"
      }
    }
    template {
      metadata {
        labels = {
          app = "minecraft"
          id  = var.server_name
        }
      }
      spec {
        container {
          name              = var.server_name
          image             = var.image
          image_pull_policy = "Always"
          port {
            container_port = 25565
          }
          startup_probe {
            exec {
              command = ["mcstatus", "localhost", "ping"]
            }
            initial_delay_seconds = "30"
            period_seconds        = "10"
            failure_threshold     = "25"
          }
          readiness_probe {
            exec {
              command = ["mcstatus", "localhost", "ping"]
            }
            period_seconds    = "5"
            failure_threshold = "5"
          }
          liveness_probe {
            exec {
              command = ["mcstatus", "localhost", "ping"]
            }
            period_seconds    = "5"
            failure_threshold = "5"
          }
          resources {
            limits = {
              cpu    = var.cpu_limit
              memory = try(var.env_variables["MEMORY"], "1G")
            }
          }
          dynamic "env" {
            for_each = var.env_variables
            content {
              name  = env.key
              value = env.value
            }
          }
          env {
            name  = "ENABLE_WHITELIST"
            value = "true"
          }
          env {
            name  = "EULA"
            value = "true"
          }
          env {
            name  = "OPS"
            value = var.server_ops
          }
          env {
            name  = "OVERRIDE_SERVER_PROPERTIES"
            value = "true"
          }
          env {
            name  = "PLUGINS_SYNC_UPDATE"
            value = "false"
          }
          env {
            name  = "TYPE"
            value = var.server_type
          }
          env {
            name  = "VERSION"
            value = var.server_version
          }
          volume_mount {
            name       = var.server_name
            mount_path = "/data"
          }
          dynamic "volume_mount" {
            for_each = var.config_map_mounts
            content {
              name       = volume_mount.key
              mount_path = volume_mount.mount_path
              sub_path   = volume_mount.sub_path
            }
          }
        }
        volume {
          name = var.server_name
          persistent_volume_claim {
            claim_name = var.server_name
          }
        }
        dynamic "volume" {
          for_each = var.config_maps
          content {
            name = volume.key
            dynamic "config_map" {
              for_each = volume.value
              content {
                name = volume
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "_" {
  metadata {
    name      = var.server_name
    namespace = var.namespace
  }
  spec {
    selector = {
      id = var.server_name
    }
    type = var.proxy_enable == false ? "LoadBalancer" : null
    port {
      port        = var.proxy_enable == false ? var.server_port : 25565
      target_port = 25565
    }
  }
}
