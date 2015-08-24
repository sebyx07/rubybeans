require 'ruby_beans/version'
require 'ruby_beans/container'
require 'ruby_beans/cache'
require 'ruby_beans/injector'

module RubyBeans
  class << self
    attr_accessor :main_container

    def get_bean(name)
      bean = RubyBeans::Cache.get(name)
      unless bean
        bean = main_container.send(name)
        RubyBeans::Cache.put(name, bean)
      end
      bean
    end
  end
end
