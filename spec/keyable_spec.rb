require 'rspec'
require './lib/Keyable'

RSpec.describe Keyable do
  describe '#needs_padding?' do
    it 'will return true if number has less than 5 digits' do
      enigma = Enigma.new
      expect(enigma.needs_padding?(100)).to eq true
      expect(enigma.needs_padding?(92834)).to eq false
    end
  end
  
  describe '#letter_key_offsets' do
    it 'sums the offsets and keys together into one array' do
      enigma = Enigma.new

      expected = [3, 27, 73, 20]
      offsets = [1, 0, 2, 5]
      keys = [2, 27, 71, 15]
      actual = enigma.letter_key_offsets(offsets, keys)

      expect(actual).to eq expected
    end
  end

  describe '#generate_keys' do
    it 'generates 4 keys from a given key' do
      enigma = Enigma.new

      actual_keys = enigma.generate_keys('02715')
      expected_keys = [2, 27, 71, 15]

      expect(actual_keys).to eq expected_keys
    end
  end

  describe '#generate_key' do
    it 'generates a new random 5 digit number' do
      enigma = Enigma.new
      key = enigma.generate_key
      expect(key.length).to eq 5
    end
    it 'Pads a zero if the random number is less than 5 digits long' do
      enigma = Enigma.new
      allow(enigma).to receive(:random).and_return(999)
      actual = enigma.generate_key
      expect(actual.length).to eq 5
    end
  end
end
