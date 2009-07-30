Given /^I have a foo model with no paths configured$/ do
  @foo = Foo.new
end

Given /^I have a bar model with paths configured, but missing data$/ do
  @bar = Bar.new
end

Given /^I have a widget model with paths configured$/ do
  @widget = Widget.new(:id => 4567, :type_name => 'Big', :name => 'Charlie')
end

Given /^I have a sprocket model with paths configured$/ do
  @sprocket = Sprocket.new(:id => 1000, :type_name => 'Medium', :name => 'Pat')
end





When /^I use the "([^\"]*)" model$/ do |model_name|
  Pathsconfig.clear
  @model = instance_variable_get("@#{model_name}")
end

When /^the "([^\"]*)" config file is configured$/ do |config_type|
  @result = PathsconfigFeature::Helpers.safe_run do
    Pathsconfig.config = File.expand_path(File.dirname(__FILE__)+"/support/#{config_type}.yml")
  end
end

When /^the "([^\"]*)" for "([^\"]*)" is called$/ do |method, path_type|
  @result = PathsconfigFeature::Helpers.safe_run do
    @model.send(method, path_type)
  end
end





Then /^pathsconfig should complain about a config error$/ do
  assert @result
  assert_kind_of Pathsconfig::ConfigError, @result
  assert_respond_to @result, :message
  assert_match "Could not load paths configuration file", @result.message
end

Then /^pathsconfig should complain about "([^\"]*)"$/ do |message|
  assert @result
  assert_kind_of Pathsconfig::PathsconfigError, @result
  assert_respond_to @result, :message
  assert_match message, @result.message
end

Then /^the model should not have paths configured$/ do
  assert @model
  assert_raises NoMethodError do
    @model.path_array
  end
  assert_raises NoMethodError do
    @model.path_string
  end
end

Then /^the model should have paths configured$/ do
  assert @model
  assert_respond_to @model, :path_array
  assert_respond_to @model, :path_string
end

Then /^result should be an array for the "([^\"]*)" model "([^\"]*)" path$/ do |model_config, path_config|
  assert @result
  assert_kind_of Array, @result
  assert @result.length > 0
  p @result
end


