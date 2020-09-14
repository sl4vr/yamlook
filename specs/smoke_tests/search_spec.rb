# frozen_string_literal: true

$LOAD_PATH.unshift("#{__dir__}/../../lib")

require 'minitest/autorun'
require 'yamlook'

describe Yamlook::Search do
  describe '.perform' do
    it 'searches correctly for nested yaml keys' do
      assert_output(%r{dummy/test\.yml:5:8\nfoo}) do
        Yamlook::Search.perform(%w[test key])
      end
    end

    it 'searches correctly for dot-notated yaml keys' do
      assert_output(%r{dummy/test\.yaml:2:12\nbar}) do
        Yamlook::Search.perform(%w[wubba lubba dub dub])
      end
    end

    it 'outputs that nothing found if nothing found' do
      assert_output(/Nothing found./) do
        Yamlook::Search.perform(%w[no such key])
      end
    end
  end
end
