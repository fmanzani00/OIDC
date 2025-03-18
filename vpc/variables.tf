variable "use_ipam_pool" {
  description = "Indica si se debe usar un pool de IPAM para asignar el bloque CIDR de la VPC."
  type        = bool
  default     = false
}

variable "cidr" {
  description = "Bloque CIDR IPv4 para la VPC. No se usa si `use_ipam_pool` es `true`."
  type        = string
  default     = null
}

variable "ipv4_ipam_pool_id" {
  description = "ID del pool de IPAM para asignar un bloque CIDR IPv4 a la VPC."
  type        = string
  default     = null
}

variable "ipv4_netmask_length" {
  description = "Longitud de la máscara de red para el bloque CIDR IPv4 asignado desde el pool de IPAM."
  type        = number
  default     = null
}

variable "enable_ipv6" {
  description = "Habilita o deshabilita la asignación de un bloque CIDR IPv6 a la VPC."
  type        = bool
  default     = false
}

variable "ipv6_cidr" {
  description = "Bloque CIDR IPv6 para la VPC. Solo se usa si `ipv6_ipam_pool_id` es `null`."
  type        = string
  default     = null
}

variable "ipv6_ipam_pool_id" {
  description = "ID del pool de IPAM para asignar un bloque CIDR IPv6 a la VPC."
  type        = string
  default     = null
}

variable "ipv6_netmask_length" {
  description = "Longitud de la máscara de red para el bloque CIDR IPv6 asignado desde el pool de IPAM."
  type        = number
  default     = null
}

variable "ipv6_cidr_block_network_border_group" {
  description = "Grupo de borde de red para el bloque CIDR IPv6. Útil en regiones con múltiples zonas locales."
  type        = string
  default     = null
}

variable "instance_tenancy" {
  description = "Tipo de tenencia de las instancias en la VPC. Valores posibles: `default` o `dedicated`."
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Habilita o deshabilita la asignación de nombres DNS a las instancias en la VPC."
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilita o deshabilita el soporte de DNS en la VPC."
  type        = bool
  default     = true
}

variable "enable_network_address_usage_metrics" {
  description = "Habilita o deshabilita la métrica de uso de direcciones de red en la VPC."
  type        = bool
  default     = false
}

variable "name" {
  description = "Nombre de la VPC. Se usa como valor del tag `Name`."
  type        = string
}

variable "tags" {
  description = "Mapa de tags comunes para todos los recursos."
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Mapa de tags específicos para la VPC."
  type        = map(string)
  default     = {}
}

variable "ipv4_additional_cidr_block_associations" {
  description = "Mapa de configuraciones para asociar bloques CIDR IPv4 adicionales a la VPC. Cada elemento del mapa debe contener el bloque CIDR IPv4 y, opcionalmente, el ID del pool de IPAM y la longitud de la máscara de red."
  type = map(object({
    ipv4_cidr_block    = string
    ipv4_ipam_pool_id  = optional(string)
    ipv4_netmask_length = optional(number)
  }))
  default = {}
}

variable "internet_gateway_enabled" {
  description = "Habilita o deshabilita la creación de un Internet Gateway (IGW) para la VPC."
  type        = bool
  default     = true
}

variable "igw_tags" {
  description = "Mapa de tags para aplicar al Internet Gateway (IGW)."
  type        = map(string)
  default     = {}
}

variable "ipv6_egress_only_internet_gateway_enabled" {
  description = "Habilita o deshabilita la creación de un Egress Only Internet Gateway para tráfico IPv6 saliente."
  type        = bool
  default     = false
}

variable "egress_igw_tags" {
  description = "Mapa de tags para aplicar al Egress Only Internet Gateway."
  type        = map(string)
  default     = {}
}

variable "enable_ipv4_block" {
  description = "Habilita o deshabilita la asociación de bloques CIDR IPv4 adicionales a la VPC."
  type        = bool
  default     = false
}

variable "ipv4_cidr_block_associations" {
  description = "Mapa de configuraciones para asociar bloques CIDR IPv4 adicionales a la VPC."
  type = map(object({
    ipv4_cidr_block    = string
    ipv4_ipam_pool_id  = string
    ipv4_netmask_length = number
  }))
  default = {}
}

variable "ipv4_cidr_block_association_timeouts" {
  description = "Configuración de timeouts para la asociación de bloques CIDR IPv4."
  type = object({
    create = string
    delete = string
  })
  default = null
}

variable "enable_ipv6_block" {
  description = "Habilita o deshabilita la asociación de bloques CIDR IPv6 adicionales a la VPC."
  type        = bool
  default     = false
}

variable "ipv6_additional_cidr_block_associations" {
  description = "Mapa de configuraciones para asociar bloques CIDR IPv6 adicionales a la VPC."
  type = map(object({
    ipv6_cidr_block    = string
    ipv6_ipam_pool_id  = string
    ipv6_netmask_length = number
  }))
  default = {}
}

variable "ipv6_cidr_block_association_timeouts" {
  description = "Configuración de timeouts para la asociación de bloques CIDR IPv6."
  type = object({
    create = string
    delete = string
  })
  default = null
}

variable "service_name" {
  description = "The service name for the VPC endpoint (e.g., com.amazonaws.us-west-2.ec2)"
  type        = string
}

variable "vpc_endpoint_type" {
  description = "The type of VPC endpoint (Interface, Gateway, or GatewayLoadBalancer)"
  type        = string
  default     = "Interface"
}

variable "subnet_configurations" {
  description = "List of subnet configurations for the VPC endpoint"
  type = list(object({
    ipv4      = string
    subnet_id = string
  }))
  default = []
}

variable "subnet_ids" {
  description = "List of subnet IDs where the VPC endpoint will be associated"
  type        = list(string)
  default     = []
}