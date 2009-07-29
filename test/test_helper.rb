# http://sneaq.net/textmate-wtf
$:.reject! { |e| e.include? 'TextMate' }

require 'rubygems'

require File.dirname(__FILE__) + '/../lib/pathsconfig'