module Pathsconfig
  module Extensions
    module Hash
      
      module ClassMethods

        unless ::Hash.respond_to?('symbolize_keys')
          # inspired by from ActiveSupport::CoreExtensions::Hash::Keys (http://api.rubyonrails.org/)
          def symbolize_keys(hash)
            hash.keys.each{ |key| hash[(key.to_sym rescue key)] ||= hash.delete(key) }
            hash
          end
        end
        
      end
      
      module InstanceMethods
        
        unless {}.respond_to?('symbolize_keys')
          # Return a new hash with all keys converted to strings.
          def symbolize_keys
            self.class.symbolize_keys(self.clone)
          end
          # Destructively convert all keys to strings. 
          def symbolize_keys!
            self.class.symbolize_keys(self)
          end
        end

      end
      
      def self.included(receiver)
        receiver.extend         ClassMethods
        receiver.send :include, InstanceMethods
      end
    
    end
  end
end

class Hash
  include Pathsconfig::Extensions::Hash
end
