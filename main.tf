provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "paper_servers" {
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
          name  = each.key
          image = "imkumpy/paper-mc:main"
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
            mount_path = "/data/plugins/Essentials"
          }
          volume_mount {
            name       = "paper-luckperms-volume"
            mount_path = "/data/plugins/LuckPerms"
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
          name  = each.key
          image = "imkumpy/fabric-mc:main"
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
            mount_path = "/config"
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
          image = "imkumpy/waterfall-mc:main"
          name  = "waterfall-proxy"
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
          volume_mount {
            name       = "waterfall-luckperms-volume"
            mount_path = "/data/plugins/LuckPerms"
          }
        }
        volume {
          name = "waterfall-luckperms-volume"
          config_map {
            name = "waterfall-luckperms-configmap"
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