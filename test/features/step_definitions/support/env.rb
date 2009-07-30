require 'test/unit/assertions'
World(Test::Unit::Assertions)

module PathsconfigFeature
  module Helpers
    
    def self.safe_run
      begin
        yield
      rescue Exception => err
        err
      end
    end

  end
end


require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'lib', 'pathsconfig.rb'))

class Foo
end

class Bar
  
  include Pathsconfig::Base

end

class Widget
  
  include Pathsconfig::Base
  def self.path_config
    :widget
  end
  def path_type
    type_name == "Big" ? :old : :new
  end

  ATTRS = [:id, :type_name, :name]
  ATTRS.each {|a| attr_reader a }
  
  def initialize(params={})
    ATTRS.each{|a| instance_variable_set("@#{a.to_s}", params[a]) }
  end
  
end

class Sprocket
  
  include Pathsconfig::Base
  def self.path_config
    :sprocket
  end
  def path_type
    widget.path_type
  end

  ATTRS = [:id, :type_name, :name]
  ATTRS.each {|a| attr_reader a }
  
  def initialize(params={})
    ATTRS.each{|a| instance_variable_set("@#{a.to_s}", params[a]) }
  end
  
  def widget
    @widget ||= Widget.new(:id => 1234, :type_name => 'Small', :name => 'Sarah')
  end
  
end
