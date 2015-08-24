require 'singleton'
module RubyBeans
  class Container
    include Singleton

    attr_accessor :dependency_loading_called, :dependent_containers, :dependent_containers_names

    def initialize
      @dependency_loading_called = false
      @dependent_containers_names = []
      @dependent_containers = []
    end
    class << self
      def load_containers(*containers)
        self.instance.dependency_loading_called = true
        self.instance.dependent_containers_names = containers
      end

      def _load_container_instances
        self.instance.dependent_containers_names.each do |container|
          self.instance.dependent_containers.push(Object.const_get(container).send(:instance))
        end
      end
    end

    def method_missing(name, *args, &block)
      name = name.to_s

      if dependency_loading_called && dependent_containers.empty?
        self.class._load_container_instances
      end

      if name.start_with?('get_') && name.end_with?('_bean')
        result = nil
        dependent_containers.each do |container|
          result = container.send(name)
        end
        result
      elsif name.end_with?('_bean')
        bean = RubyBeans::Cache.get name
        unless bean
          bean = self.send("get_#{name}")
          RubyBeans::Cache.put(name, bean)
        end
        bean
      else
        super
      end
    end
  end
end