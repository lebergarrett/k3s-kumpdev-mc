resource "kubernetes_deployment" "luckperms_mariadb" {
  count = length(var.paper_config) > 0 ? 1 : 0
  metadata {
    name      = "luckperms-mariadb"
    namespace = var.namespace
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
  count = length(var.paper_config) > 0 ? 1 : 0
  metadata {
    name      = "luckperms-mariadb"
    namespace = var.namespace
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
