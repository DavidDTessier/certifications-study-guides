# Test for validating the example/hello-world module


run "invalid_name_should_fail" {

  module {
    source = "../../examples/simple_root_config"
  }
  variables {
    prefix = "temp"
  }

  command = plan
  
  assert {
    condition     = aws_instance.example.tags.Name == "test-example"
    error_message = "Name did not match expected output"
  }
}

run "valid_name_should_pass" {

  module {
    source = "../../examples/simple_root_config"
  }
  variables {
    prefix = "test"
  }

  command = plan
  
  assert {
    condition     = aws_instance.example.tags.Name == "test-example"
    error_message = "Name did not match expected output"
  }
}
