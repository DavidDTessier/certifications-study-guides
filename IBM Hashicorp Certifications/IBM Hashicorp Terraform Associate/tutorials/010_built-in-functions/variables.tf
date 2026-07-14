

variable "str" {
  type    = string
  default = "hello world"
}

variable "items" {
  type    = list(any)
  default = [null, "", "last"]
}

variable "stuff" {
  type = map(any)
  default = {
    "hello"   = "world"
    "goodbye" = "day"
  }
}

variable "objects" {
  type = list(any)
  default = [{
    id   = 1,
    name = "test"
    },
    {
      id   = 2,
      name = "bob"
    }
  ]
}
