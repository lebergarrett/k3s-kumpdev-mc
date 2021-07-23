provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "luckperms_mariadb" {
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

resource "time_sleep" "wait_for_mariadb" {
  depends_on = [kubernetes_deployment.luckperms_mariadb]

  create_duration = "10s"
}

resource "kubernetes_deployment" "paper_servers" {
  depends_on = [time_sleep.wait_for_mariadb]
  for_each = var.paper_config
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
  depends_on = [time_sleep.wait_for_mariadb]
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

resource "kubernetes_service" "mc_servers" {
  depends_on = [time_sleep.wait_for_mariadb]
  for_each = merge(var.fabric_config, var.paper_config)
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

resource "kubernetes_deployment" "waterfall_proxy" {
  metadata {
    name      = "waterfall-proxy"
    namespace = var.server_name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "waterfall-proxy"
      }
    }
    template {
      metadata {
        labels = {
          app = "waterfall-proxy"
        }
      }
      spec {
        container {
          image             = "itzg/bungeecord:latest"
          name              = "waterfall-proxy"
          image_pull_policy = "Always"
          port {
            container_port = 25577
          }
          env {
            name  = "TYPE"
            value = "WATERFALL"
          }
          volume_mount {
            name       = "waterfall-proxy-volume"
            mount_path = "/config"
          }
        }
        volume {
          name = "waterfall-proxy-volume"
          config_map {
            name = "waterfall-proxy-configmap"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "waterfall_proxy" {
  metadata {
    name      = "waterfall-proxy"
    namespace = var.server_name
  }
  spec {
    selector = {
      app = "waterfall-proxy"
    }
    type = "LoadBalancer"
    port {
      port        = 25565
      target_port = 25577
    }
  }
}