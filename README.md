# RubyBeans

*simple to use and test dependency injection framework*

**RubyBeans** is a better alternative to
```ruby
class MyClass
  include Singleton
end
#singleton classes
MyClass.instance

class MyCache
  class << self
    def my_cached_item
      ...
    end
  end
end
# global accessable objects(cacheable)
MyCache.my_cached_item

class MyService
  include Singleton
  def my_method; end
end

class ProductsController < ApplicationController
  def index
    # polute code with hard to test code
    # increases coupling
    MyService.instance.my_method
  end
end
```

### Define beans

```ruby
class MyContainer < RubyBeans::Container
  # load dependent container
  load_containers 'MyContainer2'

  def get_first_bean
    1 + second_bean # => 3
  end

  def get_second_bean
    2
  end

  def get_third_bean
    3 + forth_bean #=> 7
  end

  def get_fifth_bean
    sixth_bean #=> nil
  end
end

class MyContainer2 < RubyBeans::Container
  def get_forth_bean
    4
  end
end
```

### Usage

```ruby
# get a bean manualy by name
RubyBeans.get_bean('first_bean') # => 3

# inject them into your class instances

class MyClass
  extend RubyBeans::Injector

  inject :first_bean, :second_MyContainerMyContainerbean
end

my_ins = MyClass.new
my_ins.first_bean #=> 3
my_ins.second_bean #=> 2
```

### Test

Load helpers
```ruby
require 'ruby_beans/stub'
RSpec.configure do |c|
  c.include RubyBeans::Stub
end
```

```ruby
# test containers
subject(:container){ MyContainer.instance)
it 'has the bean' do
  expect(container.first_bean).to eq 3 # to use cache
  expect(container.get_first_bean).to eq 3 # without cache
end

# stub containers
before do
  @my_container = stub_container do
    def get_my_bean
      33
    end
  end
end

it 'my test' do
  expect(@my_container.class).to be_a Class # @container is class
  expect(@my_containe.instance).to be_a RubyBeans::Container #access the instance
end
# stub_container_main is the same as stub_container, it just sets the  # RubyBeans.main_container too.

# stub beans
before do
 stub_bean('test', 1)
end

it 'stubs the bean' do
  expect(RubyBeans.get_bean('test')).to eq 1
end
```

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_beans'
```
```ruby
# load it as soon as possible, for rails create a initializer file
# main container is the root of all dependent containers
RubyBeans.main_container = MyContainer
```


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

