variable "enable_ddns" {
  description = "Whether or not to set up Dynamic DNS for the deployment"
  type        = bool
  default     = false
}

variable "fabric_config" {
  description = "env vars for the vanilla server"
  type        = map(map(string))
  default     = {}
}

variable "ftb_config" {
  description = "env vars for the ftb server"
  type        = map(map(string))
  default     = {}
}

variable "mc_connection_port" {
  description = "Port used to connect to server network"
  type        = string
  default     = "25565"
}

variable "mc_ops" {
  description = "List of ops for server, in string"
  type        = string
}

variable "mc_version" {
  description = "Minecraft version"
  type        = string
}

variable "image_tag" {
  description = "tag for my personal mc images"
  type        = string
}

variable "paper_config" {
  description = "env vars for the vanilla server"
  type        = map(map(string))
  default     = {}
}

variable "proxy_type" {
  description = "The type of proxy to be used by the server network"
  type        = string
  default     = "WATERFALL"

  validation {
    condition     = contains(["BUNGEECORD", "WATERFALL", "VELOCITY", "NONE"], var.proxy_type)
    error_message = "Valid values for var: proxy_type are (BUNGEECORD, WATERFALL, VELOCITY)."
  }
}

variable "proxy_motd" {
  description = "Message of the day for the waterfall proxy (What clients see on the server browser)"
  type        = string
  default     = "This is a server network powered by Kubernetes!"
}

variable "proxy_priority_server" {
  description = "Default server for player to login to on first join"
  type        = string
  default     = ""
}

variable "server_name" {
  description = "Name of server/network, used in various locations"
  type        = string
}

variable "MARIADB_USER" {
  description = "User for database that stores luckperms info (paper servers)"
  type        = string
}

variable "MARIADB_PASS" {
  description = "Password for database that stores luckperms info (paper servers)"
  type        = string
}