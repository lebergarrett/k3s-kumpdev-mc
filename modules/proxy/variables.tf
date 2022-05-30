variable "config_map_mounts" {
  type = map(object({
    mount_path = string
    sub_path   = optional(string)
  }))
  description = "Map of Locations to mount the configmaps, key is volume name"
}

variable "config_maps" {
  type        = map(string)
  description = "Map of configmaps, key is volume name, value is the configmap name"
}

variable "cpu_limit" {
  type        = string
  default     = 1
  description = "vcpus to limit the proxy to"
}

variable "image" {
  type        = string
  description = "Container image to use for proxy"
}

variable "mem_limit" {
  type        = string
  default     = "512M"
  description = "memory to limit the proxy to"
}

variable "namespace" {
  type        = string
  description = "kubernetes namespace to deploy into"
}

variable "proxy_port" {
  type        = number
  default     = 25565
  description = "Port to host the proxy on"
}

variable "proxy_type" {
  type        = string
  description = "Type of proxy (WATERFALL, BUNGEECORD, VELOCITY)"
}
