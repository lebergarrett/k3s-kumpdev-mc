locals {
  server_count = length(merge(var.fabric_config, var.paper_config, var.curseforge_config))
}
