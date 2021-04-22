require 'rspec'
require './lib/enigma'


RSpec.describe Enigma do
  describe '#new' do
    it 'Tests that it exists' do
      enigma = Enigma.new
      expect(enigma).to be_an Enigma
    end
  end

  describe '#encrypt' do
    it 'Encrypts text using optional params' do
      enigma = Engima.new

      expected = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
      actual = enigma.encrypt('Hello World', '02715', '040895')

      expect(actual).to eq expected
    end
  end

  describe '#generate_key' do
    it 'generates a new random 5 digit number' do
      enigma = Engima.new
      key = enigma.generate_key
      expect(key.length).to eq 5
    end
    xit 'Pads a zero if the random number is less than 5 digits long' do

    end
  end
end
