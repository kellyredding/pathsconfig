module Pathsconfig
  module Base
    
    module ClassMethods
      
    end
    
    module InstanceMethods

      def path_array(path_name)
        raise Pathsconfig::ConfigError, "Pathsconfig has not been configured." unless Pathsconfig.config
        raise Pathsconfig::ModelError, "class '#{self.class.name}' does not respond to the 'path_config' method." unless self.class.respond_to?(:path_config)
        path_value = Pathsconfig.config[self.class.path_config.to_sym][path_name.to_sym]
        if path_value.kind_of?(Hash)
          raise Pathsconfig::ModelError, "multiple path types are configured and this model does not respond to the 'path_type' method." unless self.respond_to?(:path_type)
          raise Pathsconfig::ModelError, "an '#{self.path_type}' type of the '#{path_name}' path has not been configured" if path_value[self.path_type.to_sym].nil?
          path_value[self.path_type.to_sym].collect{ |exp| eval(exp) }.flatten
        elsif path_value.kind_of?(Array)
          path_value.collect{ |exp| eval(exp) }.flatten
        elsif path_value.nil? || path_value.empty?
          raise Pathsconfig::ModelError, "'#{path_name}' is not configured for #{self.class.name}"
        else
          raise Pathsconfig::ModelError, "'#{path_name}' is incorrectly configured for #{self.class.name}"
        end
      end

      def path_string(path_name, options={})
        options ||= {}
        options[:type] ||= :system
        options[:root] ||= Pathsconfig.root

        case options[:type].to_sym
        when :system
          File.join((options[:root] + self.path_array(path_name)).compact)
        else
          ""
        end
      end
      
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
    
  end
end