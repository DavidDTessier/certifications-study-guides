
# Primative data types

# Define a variable for a string value (e.g., server_name)
variable "server_name" {
  type = string
  description = "Name of the server"
  default = "web-server"
}

# Define a variable for a boolean value
variable "enable_feature" {
  type = bool
  description = "Enable or disable a feature"
  default = true
}

# Define a variable for a numeric value
variable "instance_count" {
  type = number
  description = "Number of instances"
  default = 2
}

# Collection Type in Terraform

# Collections type serve as containers for managing multiple values, usuallu

variable "planets" {
    type = list(string)
    description = "example of list of string type variable"
    default = ["mars","earth", "moon"]
}

variable "mixed_list" {
    type = list(any)
    description = "a list allowing elements of any type"
    default = ["item1",42, true, "moon", 3.14]
}

# Define a variable for a map of string values (e.g., key-value pairs)
variable "plans" {
    type = map(string)
    default = {
        PlanA = "10 USD"
        PlanB = "50 USD"
        PlanC = "100 USD"
    }
}

# SET is an unorder list of unique values
variable "my_set" {
    type = set(string)
    description = "value"
    default = [ "value1", "value2", "value3" ]
}

# Structural Types In Terraform

# tuple(): A sequence of values each with their own type, in order
variable "example_tuple" {
  type = tuple([ string, number, bool ])
  default = [ "test", 0, false ]
}

# Objects
variable "plan" {
    type = object({
        PlanName = string
        PlanAmount = number
    })
    default = {
        PlanName = "Basic",
        PlanAmount = 10
    }
}
