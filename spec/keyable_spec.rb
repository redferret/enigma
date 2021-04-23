require 'rspec'
require './spec/dummyenigma'
require './lib/Keyable'

RSpec.describe Keyable do
  before :all do
    @dummyenigma = DummyEnigma.new
  end
  describe '#offset_keys' do
    it 'sums the offsets and keys together into one array' do
      expected = [3, 27, 73, 20]
      offsets = [1, 0, 2, 5]
      keys = [2, 27, 71, 15]
      actual = @dummyenigma.offset_keys(offsets, keys)

      expect(actual).to eq expected
    end
  end

  describe '#generate_keys' do
    it 'generates 4 keys from a given key' do
      actual_keys = @dummyenigma.generate_keys('02715')
      expected_keys = [2, 27, 71, 15]

      expect(actual_keys).to eq expected_keys
    end
  end

  describe '#generate_key' do
    it 'generates a new random 5 digit number' do
      key = @dummyenigma.generate_key
      expect(key.length).to eq 5
    end
    it 'Pads a zero if the random number is less than 5 digits long' do
      allow(@dummyenigma).to receive(:random).and_return(999)
      actual = @dummyenigma.generate_key
      expect(actual.length).to eq 5
    end
  end
end
