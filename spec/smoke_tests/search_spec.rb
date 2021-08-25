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
        Found\s7\soccurrences:\n
        .+dummy/test.yaml:1:22\n
        bar\n
        \n
        .+dummy/test.yaml:5:12\n
        bar1\n
        \n
        .+dummy/test.yaml:7:12\n
        bar2\n
        \n
        .+dummy/test.yaml:13:12\n
        bar3\n
        \n
        .+dummy/test.yaml:15:24\n
        bar4\n
        \n
        .+dummy/test.yaml:18:14\n
        bar5\n
        \n
        .+dummy/test.yaml:22:25\n
        bar6\n
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
          .+dummy/test\.yaml:23:17\n
          true
        }x
      ) do
        Yamlook::Search.perform(%w[test duplicate])
      end
    end

    it 'searches correctly for dot-notated yaml keys' do
      skip 'When first node is scalar - file won\'t be parsed properly'
      assert_output(%r{
        Found\s1\soccurrences:\n
        .+dummy/erb\.yaml:6:6\n
        works
      }x) do
        Yamlook::Search.perform(%w[erb])
      end
    end

    it 'outputs that nothing found if nothing found' do
      assert_output(/Nothing found./) do
        Yamlook::Search.perform(%w[no such key])
      end
    end

    it 'outputs that nothing to search for if no keys were given' do
      assert_output(/Nothing to search for./) do
        Yamlook::Search.perform([])
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
