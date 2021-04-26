require 'rspec'
require './spec/dummyenigma'
require './lib/keyable'

RSpec.describe Keyable do
  before :all do
    @dummyenigma = DummyEnigma.new
  end

  describe '#get_random_number' do
    it 'returns a number' do
      allow(@dummyenigma).to receive(:rand).and_return(43257)
      number = @dummyenigma.get_random_number(99999)

      expect(@dummyenigma).to have_received(:rand)
      expect(number).to eq 43257
    end
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
    it 'generates a new 5 digit number' do
      allow(@dummyenigma).to receive(:get_random_number).and_return(43242)
      allow(@dummyenigma).to receive(:not_a_valid_key?).and_return(false)

      key = @dummyenigma.generate_key

      expect(key.length).to eq 5
      expect(key).to eq '43242'
    end
    it 'Pads a zero if the random number is less than 5 digits long' do
      allow(@dummyenigma).to receive(:get_random_number).and_return(999)
      allow(@dummyenigma).to receive(:not_a_valid_key?).and_return(true)
      actual = @dummyenigma.generate_key
      expect(actual.length).to eq 5
    end
  end

  describe '#not_a_valid_key?' do
    it 'negates value on valid_key?' do
      allow(Validable).to receive(:valid_key?).and_return(false)
      actual_validable = @dummyenigma.not_a_valid_key?(123)
      expect(actual_validable).to eq true
    end
  end
end
