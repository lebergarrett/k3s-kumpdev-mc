provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "_" {
  metadata {
    name = var.server_name
  }
}

resource "kubernetes_deployment" "vanilla" {
  metadata {
    name      = "vanilla"
    namespace = kubernetes_namespace._.metadata.0.name
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
          image = "itzg/minecraft-server"
          name  = "vanilla-mc"
          port {
            container_port = 25565
          }
          dynamic "env" {
            for_each = var.vanilla_env_vars
            content {
              name  = env.key
              value = env.value
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "vanilla" {
  metadata {
    name      = "vanilla"
    namespace = kubernetes_namespace._.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.vanilla.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port   = 31101
      port        = 25565
      target_port = 25565
    }
  }
}