module RubyBeans
  class Cache
    @@_hash = Hash.new

    class << self
      def get(name)
        @@_hash[name]
      end

      def put(name, obj)
        @@_hash[name] = obj
      end

      def get_or_put(name, obj)
        unless get(name)
          put(name, obj)
        end
        get(name)
      end

      def hash
        @@_hash
      end
    end
  end
end