resource "kubernetes_deployment" "ddns" {
  metadata {
    name      = "ddns-ddclient"
    namespace = var.server_name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "ddns-ddclient"
      }
    }
    template {
      metadata {
        labels = {
          app = "ddns-ddclient"
        }
      }
      spec {
        container {
          image = "linuxserver/ddclient"
          name  = "ddns-ddclient"
          env {
            name  = "PUID"
            value = "1000"
          }
          env {
            name  = "PGID"
            value = "1000"
          }
          env {
            name  = "TZ"
            value = "America/Los_Angeles"
          }
          volume_mount {
            name       = "ddns-ddclient-volume"
            mount_path = "/config"
          }
        }
        volume {
          name = "ddns-ddclient-volume"
          config_map {
            name = "ddns-ddclient-configmap"
          }
        }
      }
    }
  }
}