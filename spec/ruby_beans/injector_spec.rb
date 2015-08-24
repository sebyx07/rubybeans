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

  it 'has my_bean and my_second_bean defined' do
    expect(@instance.respond_to?(:my_bean)).to be true
    expect(@instance.respond_to?(:my_second_bean)).to be true
  end
end