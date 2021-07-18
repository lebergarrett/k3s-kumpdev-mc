variable "fabric_config" {
  description = "env vars for the vanilla server"
  type        = map(map(string))
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

variable "paper_config" {
  description = "env vars for the vanilla server"
  type        = map(map(string))
}

variable "server_name" {
  description = "Name of server/network, used in various locations"
  type        = string
}