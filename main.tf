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