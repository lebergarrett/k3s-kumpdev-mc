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
        }
      }
      spec {
        container {
          name  = each.key
          image = "itzg/minecraft-server"
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
          volume_mount {
            mount_path = "/plugins"
            sub_path   = "plugins/"
            name       = var.server_name
          }
          volume_mount {
            mount_path = "/data"
            sub_path   = "data/${each.key}"
            name       = var.server_name
          }
        }
        volume {
          name = var.server_name
          persistent_volume_claim {
            claim_name = var.server_name
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
        }
      }
      spec {
        container {
          name  = each.key
          image = "itzg/minecraft-server"
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
          volume_mount {
            mount_path = "/mods"
            sub_path   = "fabric-mods/"
            name       = var.server_name
          }
          volume_mount {
            mount_path = "/data"
            sub_path   = "data/${each.key}"
            name       = var.server_name
          }
        }
        volume {
          name = var.server_name
          persistent_volume_claim {
            claim_name = var.server_name
          }
        }
      }
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
          image = "itzg/bungeecord"
          name  = "waterfall-proxy"
          port {
            container_port = 25577
          }
          env {
            name  = "TYPE"
            value = "WATERFALL"
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
      app = kubernetes_deployment.waterfall_proxy.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port        = 25565
      target_port = 25577
    }
  }
}