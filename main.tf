provider "kubernetes" {
  config_path = "~/.kube/config"
}


resource "kubernetes_config_map" "paper_essentials" {
  metadata {
    name      = "paper-essentials-configmap"
    namespace = var.server_name
  }
  data = {
    "config.yml" = file("${path.root}/templates/essentials-config.tpl")
  }
}

resource "kubernetes_config_map" "paper_luckperms" {
  for_each = var.paper_config
  metadata {
    name      = "${each.key}-luckperms-configmap"
    namespace = var.server_name
  }
  data = {
    "config.yml" = templatefile("${path.root}/templates/luckperms-paper-config.tpl", {
      server          = each.key
      mariadb_address = "luckperms-mariadb"
      mariadb_db      = "luckperms"
      mariadb_user    = var.MARIADB_USER
      mariadb_pass    = var.MARIADB_PASS
    })
  }
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
            name       = "paper-essentials-volume"
            mount_path = "/data/plugins/Essentials"
          }
          volume_mount {
            name       = "paper-luckperms-volume"
            mount_path = "/data/plugins/LuckPerms"
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

resource "kubernetes_config_map" "fabric_servers" {
  metadata {
    name      = "fabric-servers-configmap"
    namespace = var.server_name
  }
  data = {
    "FabricProxy.toml" = file("${path.root}/templates/FabricProxy.tpl")
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

resource "kubernetes_config_map" "waterfall_proxy" {
  metadata {
    name      = "waterfall-proxy-configmap"
    namespace = var.server_name
  }
  data = {
    "config.yml" = templatefile("${path.root}/templates/waterfall-config.tpl", {
      mc_ops                = var.mc_ops
      proxy_motd            = var.proxy_motd
      proxy_priority_server = var.proxy_priority_server
      servers               = concat([for server, config in var.paper_config : server], [for server, config in var.fabric_config : server])
    })
  }
}

resource "kubernetes_config_map" "waterfall_luckperms" {
  metadata {
    name      = "waterfall-luckperms-configmap"
    namespace = var.server_name
  }
  data = {
    "config.yml" = file("${path.root}/templates/luckperms-bungee-config.tpl")
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