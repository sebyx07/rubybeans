require 'spec_helper'

RSpec.describe RubyBeans::Stub do
  describe '#stub_bean' do
    before do
      stub_bean('test', 1)
    end

    it 'stubs the bean' do
      expect(RubyBeans.get_bean('test')).to eq 1
    end
  end

  describe '#stub_container' do
    before do
      container_k = stub_container do
        def get_my_bean
          33
        end
      end

      @container = container_k.instance
    end

    it 'container has the bean' do
      expect(@container.my_bean).to eq 33
    end
  end

  describe '#stub_main_container' do
    before do
      stub_main_container do
        def get_my_main_bean
          333
        end
      end
      @container = RubyBeans.main_container.instance
    end

    it 'container has the bean' do
      expect(@container.get_my_main_bean).to eq 333
    end
  end
end