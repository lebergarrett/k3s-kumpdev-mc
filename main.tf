provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "luckperms_mariadb" {
  count = var.paper_config != {} ? 1 : 0
  metadata {
    name      = "luckperms-mariadb"
    namespace = var.server_name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "luckperms-mariadb"
      }
    }
    template {
      metadata {
        labels = {
          app = "luckperms-mariadb"
        }
      }
      spec {
        container {
          image = "mariadb"
          name  = "luckperms-mariadb"
          port {
            container_port = 3306
          }
          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = var.MARIADB_PASS
          }
          env {
            name  = "MYSQL_DATABASE"
            value = "luckperms"
          }
          env {
            name  = "MYSQL_USER"
            value = var.MARIADB_USER
          }
          env {
            name  = "MYSQL_PASSWORD"
            value = var.MARIADB_PASS
          }
          volume_mount {
            mount_path = "/var/lib/mysql"
            name       = "luckperms-mariadb-volume"
          }
        }
        volume {
          name = "luckperms-mariadb-volume"
          persistent_volume_claim {
            claim_name = "luckperms-mariadb"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "luckperms_mariadb" {
  count = var.paper_config != {} ? 1 : 0
  metadata {
    name      = "luckperms-mariadb"
    namespace = var.server_name
  }
  spec {
    selector = {
      app = "luckperms-mariadb"
    }
    port {
      port        = 3306
      target_port = 3306
    }
  }
}

resource "kubernetes_deployment" "paper_servers" {
  depends_on = [kubernetes_deployment.luckperms_mariadb]
  for_each   = var.paper_config
  metadata {
    name      = each.key
    namespace = var.server_name
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
          id  = each.key
        }
      }
      spec {
        container {
          name              = each.key
          image             = "imkumpy/paper-mc:main"
          image_pull_policy = "Always"
          port {
            container_port = 25565
          }
          readiness_probe {
            exec {
              command = ["mcstatus", "localhost", "ping"]
            }
            initial_delay_seconds = "90"
            period_seconds        = "5"
          }
          liveness_probe {
            exec {
              command = ["mcstatus", "localhost", "ping"]
            }
            initial_delay_seconds = "90"
            period_seconds        = "5"
          }
          dynamic "env" {
            for_each = var.paper_config[each.key]
            content {
              name  = env.key
              value = env.value
            }
          }
          env {
            name  = "TYPE"
            value = "PAPER"
          }
          env {
            name  = "VERSION"
            value = var.mc_version
          }
          env {
            name  = "ENABLE_WHITELIST"
            value = "true"
          }
          env {
            name  = "OPS"
            value = var.mc_ops
          }
          env {
            name  = "REMOVE_OLD_MODS"
            value = "true"
          }
          env {
            name  = "REMOVE_OLD_MODS_INCLUDE"
            value = "*.jar"
          }
          resources {
            requests = {
              cpu    = "0.5"
              memory = var.paper_config[each.key]["MEMORY"]
            }
          }
          volume_mount {
            mount_path = "/data"
            name       = each.key
          }
          volume_mount {
            mount_path = "/data/spigot.yml"
            sub_path   = "spigot.yml"
            name       = "paper-config-volume"
          }
          volume_mount {
            name       = "paper-essentials-volume"
            sub_path   = "config.yml"
            mount_path = "/data/plugins/Essentials/config.yml"
          }
          volume_mount {
            name       = "paper-luckperms-volume"
            sub_path   = "config.yml"
            mount_path = "/data/plugins/LuckPerms/config.yml"
          }
          volume_mount {
            name       = "whitelist-volume"
            sub_path   = "whitelist.json"
            mount_path = "/data/whitelist.json"
          }
        }
        volume {
          name = "whitelist-volume"
          config_map {
            name = "whitelist-configmap"
          }
        }
        volume {
          name = "paper-config-volume"
          config_map {
            name = "paper-configmap"
          }
        }
        volume {
          name = "paper-luckperms-volume"
          config_map {
            name = "${each.key}-luckperms-configmap"
          }
        }
        volume {
          name = "paper-essentials-volume"
          config_map {
            name = "paper-essentials-configmap"
          }
        }
        volume {
          name = each.key
          persistent_volume_claim {
            claim_name = each.key
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "fabric_servers" {
  for_each = var.fabric_config
  metadata {
    name      = each.key
    namespace = var.server_name
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
          id  = each.key
        }
      }
      spec {
        container {
          name              = each.key
          image             = "imkumpy/fabric-mc:main"
          image_pull_policy = "Always"
          port {
            container_port = 25565
          }
          readiness_probe {
            exec {
              command = ["mcstatus", "localhost", "ping"]
            }
            initial_delay_seconds = "60"
            period_seconds        = "5"
          }
          liveness_probe {
            exec {
              command = ["mcstatus", "localhost", "ping"]
            }
            initial_delay_seconds = "60"
            period_seconds        = "5"
          }
          dynamic "env" {
            for_each = var.fabric_config[each.key]
            content {
              name  = env.key
              value = env.value
            }
          }
          env {
            name  = "TYPE"
            value = "FABRIC"
          }
          env {
            name  = "VERSION"
            value = var.mc_version
          }
          env {
            name  = "ENABLE_WHITELIST"
            value = "true"
          }
          env {
            name  = "OPS"
            value = var.mc_ops
          }
          env {
            name  = "REMOVE_OLD_MODS"
            value = "true"
          }
          env {
            name  = "REMOVE_OLD_MODS_INCLUDE"
            value = "*.jar"
          }
          resources {
            requests = {
              cpu    = "1"
              memory = var.fabric_config[each.key]["MEMORY"]
            }
          }
          volume_mount {
            mount_path = "/data"
            name       = each.key
          }
          volume_mount {
            name       = "fabric-config-volume"
            sub_path   = "FabricProxy.toml"
            mount_path = "/config/FabricProxy.toml"
          }
          volume_mount {
            name       = "whitelist-volume"
            sub_path   = "whitelist.json"
            mount_path = "/data/whitelist.json"
          }
        }
        volume {
          name = "whitelist-volume"
          config_map {
            name = "whitelist-configmap"
          }
        }
        volume {
          name = "fabric-config-volume"
          config_map {
            name = "fabric-servers-configmap"
          }
        }
        volume {
          name = each.key
          persistent_volume_claim {
            claim_name = each.key
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "ftb_servers" {
  for_each = var.ftb_config
  metadata {
    name      = each.key
    namespace = var.server_name
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
          id  = each.key
        }
      }
      spec {
        container {
          name = each.key
          #image             = "itzg/minecraft-server:java8-multiarch"
          image             = "imkumpy/ftb-fabric-mc:main"
          image_pull_policy = "Always"
          port {
            container_port = 25565
          }
          readiness_probe {
            exec {
              command = ["mcstatus", "localhost", "ping"]
            }
            initial_delay_seconds = "240"
            period_seconds        = "5"
          }
          liveness_probe {
            exec {
              command = ["mcstatus", "localhost", "ping"]
            }
            initial_delay_seconds = "240"
            period_seconds        = "5"
          }
          dynamic "env" {
            for_each = var.ftb_config[each.key]
            content {
              name  = env.key
              value = env.value
            }
          }
          env {
            name = "TYPE"
            #value = "FTBA"
            value = "CURSEFORGE"
          }
          env {
            name  = "ENABLE_WHITELIST"
            value = "true"
          }
          env {
            name  = "OPS"
            value = var.mc_ops
          }
          resources {
            requests = {
              cpu    = "1"
              memory = var.ftb_config[each.key]["MEMORY"]
            }
          }
          volume_mount {
            mount_path = "/data"
            name       = each.key
          }
          # volume_mount {
          #   name       = "ftb-config-volume"
          #   sub_path   = "global.conf"
          #   mount_path = "/config/sponge/global.conf"
          # }
          volume_mount {
            name       = "whitelist-volume"
            sub_path   = "whitelist.json"
            mount_path = "/data/whitelist.json"
          }
          volume_mount {
            name       = "fabric-config-volume"
            sub_path   = "FabricProxy.toml"
            mount_path = "/config/FabricProxy.toml"
          }
        }
        volume {
          name = "fabric-config-volume"
          config_map {
            name = "fabric-servers-configmap"
          }
        }
        volume {
          name = "whitelist-volume"
          config_map {
            name = "whitelist-configmap"
          }
        }
        # volume {
        #   name = "ftb-config-volume"
        #   config_map {
        #     name = "ftb-servers-configmap"
        #   }
        # }
        volume {
          name = each.key
          persistent_volume_claim {
            claim_name = each.key
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mc_servers" {
  depends_on = [kubernetes_deployment.luckperms_mariadb, kubernetes_deployment.velocity_proxy]
  for_each   = merge(var.fabric_config, var.paper_config, var.ftb_config)
  metadata {
    name      = each.key
    namespace = var.server_name
  }
  spec {
    selector = {
      id = each.key
    }
    port {
      port        = 25565
      target_port = 25565
    }
  }
}

resource "kubernetes_deployment" "velocity_proxy" {
  count = length(merge(var.fabric_config, var.paper_config, var.ftb_config)) > 1 && var.proxy_type == "VELOCITY" ? 1 : 0
  metadata {
    name      = "velocity-proxy"
    namespace = var.server_name
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
          image             = "imkumpy/waterfall-mc:main"
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

resource "kubernetes_deployment" "waterfall_proxy" {
  count = length(merge(var.fabric_config, var.paper_config, var.ftb_config)) > 1 && (var.proxy_type == "WATERFALL" || var.proxy_type == "BUNGEECORD") ? 1 : 0
  metadata {
    name      = "waterfall-proxy"
    namespace = var.server_name
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
          image             = "imkumpy/waterfall-mc:main"
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

resource "kubernetes_service" "mc_proxy" {
  metadata {
    name      = "mc-proxy"
    namespace = var.server_name
  }
  spec {
    selector = {
      app = "mc-proxy"
    }
    type = "LoadBalancer"
    port {
      port        = 25565
      target_port = 25577
    }
  }
}