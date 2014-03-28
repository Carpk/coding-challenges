require 'minitest/spec'
require 'minitest/autorun'

class GiftIdea
  class << self
    def search(term)
    end
  end
end

describe GiftIdea do
  let(:data) { File.read('data.json') }

  before do
    #
  end

  describe '.search' do
    it 'returns records which contain "Cake" in the title' do
      titles = GiftIdea.search('Cake').map(&:title)
      titles.must_include "3D Cake Moulds"
    end

    it 'returns records which contain "shoes" in the description' do
      descriptions = GiftIdea.search('shoes').map(&:description)
      descriptions.must_include "Great Shoes!"
    end
  end
end