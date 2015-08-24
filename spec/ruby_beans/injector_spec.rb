require 'spec_helper'

class TestClass
  extend RubyBeans::Injector

  inject :my_bean, :my_second_bean
end

RSpec.describe do
  before do
    @container = RubyBeans.main_container = double
    @instance = TestClass.new
  end

  it 'can access my_bean' do
    expect(@container).to receive(:my_bean)
    @instance.my_bean
  end
end