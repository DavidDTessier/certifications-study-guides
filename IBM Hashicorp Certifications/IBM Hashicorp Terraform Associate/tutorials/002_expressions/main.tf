terraform {

}


variable "hello" {
  type = string
}

variable "worlds" {
  type = list(any)
}

variable "worlds_map" {
  type = map(any)
}

variable "worlds_splat" {
  type = list(any)
}


variable "vpc_cidrs" {
  type = map(any)
}
