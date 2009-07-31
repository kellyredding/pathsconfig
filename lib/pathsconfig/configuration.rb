module Pathsconfig
  
  @@config = nil
  @@root = ""
  
  def self.config=(path)
    begin
      @@config = YAML.load_file(File.expand_path(path))
      raise Pathsconfig::ConfigError, "Could not load paths configuration file: the config must be entered as a Hash" unless @@config.kind_of?(Hash)
      @@config.symbolize_keys!
    rescue Errno::ENOENT => err
      raise Pathsconfig::ConfigError, "Could not load paths configuration file: #{err.message}"
    rescue ArgumentError => err
      raise Pathsconfig::ConfigError, "Could not load paths configuration file: #{err.message}"
    end
  end
  
  def self.config
    @@config
  end
  
  def self.clear
    @@config = nil
  end

  def self.root=(path)
    @@root = Array(path)
  end
  
  def self.root
    @@root
  end
  
end

