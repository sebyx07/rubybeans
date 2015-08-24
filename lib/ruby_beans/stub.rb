module RubyBeans
  module Stub
    def stub_bean(name, obj)
      RubyBeans::Cache.put(name, obj)
    end

    def stub_container(&block)
      Class.new RubyBeans::Container, &block
    end

    def stub_main_container(&block)
      klass = stub_container(&block)
      RubyBeans.main_container = klass
    end
  end
end