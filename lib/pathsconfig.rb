%w(yaml).each do |lib|
  require lib
end

%w(extensions exceptions configuration base).each do |file|
  require File.join(File.dirname(__FILE__), 'pathsconfig', "#{file}.rb")
end
