require 'spec_helper'

class TestContainer < RubyBeans::Container
  load_containers 'TestController2'

  def get_bean_first
    1 + bean_second
  end

  def get_bean_second
    2
  end

  def get_bean_third
    3 + bean_forth
  end

  def get_fifth
    bean_sixth
  end
end

class TestController2 < RubyBeans::Container
  def get_bean_forth
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
        @result = @container.get_bean_first
      end
      it 'gets the 3' do
        expect(@result).to eq 3
      end

      it 'puts second bean in cache' do
        expect(RubyBeans::Cache.get('bean_second')).to eq 2
      end
    end

    context 'a bean depends on a bean from another container' do
      before do
        @result = @container.get_bean_third
      end

      it 'gets the 7' do
        expect(@result).to eq 7
      end

      it 'puts second bean in cache' do
        expect(RubyBeans::Cache.get('bean_forth')).to eq 4
      end
    end

    context 'a bean was not found' do
      it 'returns a nil' do
        expect(@container.get_fifth).to be_nil
      end
    end
  end
end