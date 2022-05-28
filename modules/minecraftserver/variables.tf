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
  description = "vcpus to limit the server to"
}

variable "env_variables" {
  type        = map(string)
  default     = {}
  description = "environment variables to pass into the server container"
}

variable "image" {
  type        = string
  description = "Container image to use for servers"
}

variable "namespace" {
  type        = string
  description = "kubernetes namespace to deploy into"
}

variable "proxy_enable" {
  type        = bool
  description = "Whether you are using a minecraft proxy for the server or not."
}

variable "server_name" {
  type        = string
  description = "Name of the server"
}

variable "server_ops" {
  type        = string
  description = "Comma separated list of operators for the server (no spaces)"
}

variable "server_port" {
  type        = number
  default     = 25565
  description = "Port to host the server on, if not using a proxy"
}

variable "server_type" {
  type        = string
  description = "Type of server (paper, fabric, curseforge, etc)"
}

variable "server_version" {
  type        = string
  description = "Version of minecraft to use for the server"
}
