$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ruby_beans'
require 'ruby_beans/stub'

RSpec.configure do |c|
  c.include RubyBeans::Stub
end