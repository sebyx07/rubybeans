require 'spec_helper'

class TestContainer < RubyBeans::Container
  load_containers 'TestController2'

  def get_first_bean
    1 + second_bean
  end

  def get_second_bean
    2
  end

  def get_third_bean
    3 + forth_bean
  end

  def get_fifth_bean
    sixth_bean
  end
end

class TestController2 < RubyBeans::Container
  def get_forth_bean
    4
  end
end

RSpec.describe RubyBeans::Container do
  before do
    @container = TestContainer.instance
  end

  describe '#method_missing' do
    context 'a bean depends on another bean' do
      before do
        @result = @container.first_bean
      end
      it 'gets the 3' do
        expect(@result).to eq 3
      end

      it 'puts second bean in cache' do
        expect(RubyBeans::Cache.get('second_bean')).to eq 2
      end
    end

    context 'a bean depends on a bean from another container' do
      before do
        @result = @container.third_bean
      end

      it 'gets the 7' do
        expect(@result).to eq 7
      end

      it 'puts second bean in cache' do
        expect(RubyBeans::Cache.get('forth_bean')).to eq 4
      end
    end

    context 'a bean was not found' do
      it 'returns a nil' do
        expect(@container.fifth_bean).to be_nil
      end
    end
  end
end