# frozen_string_literal: true

$LOAD_PATH.unshift("#{__dir__}/../../lib")

require 'minitest/autorun'
require 'yamlook'

# rubocop:disable Metrics/BlockLength
describe Yamlook::Search do
  describe '.perform' do
    it 'searches correctly for nested yaml keys' do
      assert_output(%r{
        Found\s1\soccurrences:\n
        .+dummy/test\.yml:5:8\n
        foo
      }x) do
        Yamlook::Search.perform(%w[test key])
      end
    end

    it 'searches correctly for yaml keys nested in common locale codes' do
      assert_output(%r{
        Found\s1\soccurrences:\n
        .+dummy/test\.yml:14:9\n
        english
      }x) do
        Yamlook::Search.perform(%w[lang])
      end
    end

    it 'searches correctly for dot-notated yaml keys' do
      assert_output(%r{
        Found\s1\soccurrences:\n
        .+dummy/test\.yaml:2:12\n
        bar
      }x) do
        Yamlook::Search.perform(%w[wubba lubba dub dub])
      end
    end

    it 'searches correctly for several occurrences' do
      assert_output(
        %r{
          Found\s2\soccurrences:\n
          .+dummy/test\.yml:7:14\n
          true\n
          \n
          .+dummy/test\.yaml:4:14\n
          true
        }x
      ) do
        Yamlook::Search.perform(%w[test duplicate])
      end
    end

    it 'outputs that nothing found if nothing found' do
      assert_output(/Nothing found./) do
        Yamlook::Search.perform(%w[no such key])
      end
    end

    it 'outputs that nothing ti seach for if no keys were given' do
      assert_output(/Nothing to seach for./) do
        Yamlook::Search.perform([])
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
