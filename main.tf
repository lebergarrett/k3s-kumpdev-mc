terraform {
  experiments = [module_variable_optional_attrs]
}

module "paper_servers" {
  for_each = var.paper_config
  source   = "./modules/minecraftserver"

  server_name    = each.key
  server_type    = "PAPER"
  server_version = var.mc_version
  server_ops     = var.mc_ops
  server_port    = var.mc_connection_port
  image          = "imkumpy/paper-mc:${var.image_tag}"
  proxy_enable   = local.server_count > 1 ? true : false
  namespace      = var.namespace
  env_variables = merge({
    "REMOVE_OLD_MODS"          = "true"
    "REMOVE_OLD_MODES_INCLUDE" = "*.jar"
  }, each.value)

  config_maps = {
    paper-config-volume     = "paper-configmap"
    paper-essentials-volume = "paper-essentials-configmap"
    paper-luckperms-volume  = "${each.key}-luckperms-configmap"
    spigot-config-volume    = "spigot-configmap"
    whitelist-volume        = "whitelist-configmap"
  }
  config_map_mounts = {
    paper-config-volume = {
      mount_path = "/data/paper.yml"
      sub_path   = "paper.yml"
    }
    paper-essentials-volume = {
      mount_path = "/data/plugins/Essentials/config.yml"
      sub_path   = "config.yml"
    }
    paper-luckperms-volume = {
      mount_path = "/data/plugins/LuckPerms/config.yml"
      sub_path   = "config.yml"
    }
    spigot-config-volume = {
      mount_path = "/data/spigot.yml"
      sub_path   = "spigot.yml"
    }
    whitelist-volume = {
      mount_path = "/data/whitelist.json"
      sub_path   = "whitelist.json"
    }
  }
  depends_on = [kubernetes_deployment.luckperms_mariadb]
}

module "fabric_servers" {
  for_each = var.fabric_config
  source   = "./modules/minecraftserver"

  server_name    = each.key
  server_type    = "FABRIC"
  server_version = var.mc_version
  server_ops     = var.mc_ops
  server_port    = var.mc_connection_port
  image          = "imkumpy/fabric-mc:${var.image_tag}"
  proxy_enable   = local.server_count > 1 ? true : false
  namespace      = var.namespace
  cpu_limit      = 2
  env_variables = merge({
    "REMOVE_OLD_MODS"          = "true"
    "REMOVE_OLD_MODES_INCLUDE" = "*.jar"
  }, each.value)

  config_maps = {
    fabricproxy-config-volume      = "fabricproxy-configmap"
    fabricproxy-lite-config-volume = "fabricproxy-lite-configmap"
    whitelist-volume               = "whitelist-configmap"
  }
  config_map_mounts = {
    fabricproxy-config-volume = {
      mount_path = "/config/FabricProxy.toml"
      sub_path   = "FabricProxy.toml"
    }
    fabricproxy-lite-config-volume = {
      mount_path = "/config/FabricProxy-Lite.toml"
      sub_path   = "FabricProxy-Lite.toml"
    }
    whitelist-volume = {
      mount_path = "/data/whitelist.json"
      sub_path   = "whitelist.json"
    }
  }
}

module "curseforge_servers" {
  for_each = var.curseforge_config
  source   = "./modules/minecraftserver"

  server_name    = each.key
  server_type    = "CURSEFORGE"
  server_version = var.mc_version
  server_ops     = var.mc_ops
  server_port    = var.mc_connection_port
  image          = "imkumpy/ftb-fabric-mc:${var.image_tag}"
  proxy_enable   = local.server_count > 1 ? true : false
  namespace      = var.namespace
  env_variables  = each.value

  config_maps = {
    whitelist-volume = "whitelist-configmap"
  }
  config_map_mounts = {
    whitelist-volume = {
      mount_path = "/data/whitelist.json"
      sub_path   = "whitelist.json"
    }
  }
}

module "proxy" {
  count  = local.server_count > 1 ? 1 : 0
  source = "./modules/proxy"

  proxy_type = var.proxy_type
  proxy_port = var.mc_connection_port
  namespace  = var.namespace
  image      = "imkumpy/waterfall-mc:${var.image_tag}"

  config_maps = {
    velocity-proxy-volume = "velocity-proxy-configmap"
  }
  config_map_mounts = {
    velocity-proxy-volume = {
      mount_path = "/config"
    }
  }
}
