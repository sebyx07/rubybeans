module RubyBeans
  module Injector
    def inject(*dependencies)
      dependencies.each do |d|
        ds = d.to_s
        define_method(ds) do
          RubyBeans.get_bean ds
        end
      end
    end
  end
end