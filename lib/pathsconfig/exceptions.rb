module Pathsconfig
  
  class PathsconfigError < ::StandardError
  end
  
  class ConfigError < PathsconfigError
  end

  class ModelError < PathsconfigError
  end

end