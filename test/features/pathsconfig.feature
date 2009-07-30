Feature: Pathsconfig
  In order to access model based files
  As a user of this gem
  I want to configure dynamic paths based on model data
  
  Background:
    Given I have a foo model with no paths configured
    And I have a bar model with paths configured, but missing data
    And I have a widget model with paths configured
    And I have a sprocket model with paths configured
  
  Scenario: No paths
    When I use the "foo" model
    Then the model should not have paths configured

  Scenario: Can't find config file
    When the "missing" config file is configured
    Then pathsconfig should complain about a config error
  
  Scenario: Invalid config file
    When the "invalid" config file is configured
    Then pathsconfig should complain about a config error
  
  Scenario: Bad config file
    When the "bad" config file is configured
    Then pathsconfig should complain about a config error
  
  Scenario: Not configured
    When I use the "widget" model
    And the "path_array" for "static" is called 
    Then pathsconfig should complain about "Pathsconfig has not been configured."
  
  Scenario: With paths, missing model data
    When I use the "bar" model
    And the "paths" config file is configured
    And the "path_array" for "static" is called 
    Then pathsconfig should complain about "class 'Bar' does not respond to the 'path_config' method."
  
  Scenario: With static path array
    When I use the "widget" model
    And the "paths" config file is configured
    And the "path_array" for "static" is called 
    Then result should be an array for the "widget" model "static" path
  
  Scenario: With dynamic path array
    When I use the "widget" model
    And the "paths" config file is configured
    And the "path_array" for "dynamic" is called 
    Then result should be an array for the "widget" model "dynamic" path
  
  Scenario: With nested path array
    When I use the "widget" model
    And the "paths" config file is configured
    And the "path_array" for "nested" is called 
    Then result should be an array for the "widget" model "nested" path
  
  Scenario: With crazy nested path array
    When I use the "sprocket" model
    And the "paths" config file is configured
    And the "path_array" for "nested" is called 
    Then result should be an array for the "sprocket" model "nested" path
