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
    xit 'Encrypts text using optional params' do
      enigma = Enigma.new

      expected = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
      actual = enigma.encrypt('Hello World', '02715', '040895')

      expect(actual).to eq expected
    end
  end

  describe '#generate_keys' do
    it 'generates 4 keys from a given key' do
      enigma = Enigma.new

      actual_keys = enigma.generate_keys('02715')
      expected_keys = ['02', '27', '71', '15']

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

  describe '#current_date' do
    it 'returns date in format DDMMYY' do
      enigma = Enigma.new

      actual_date = enigma.current_date

      expect(actual_date).to match /\d{6}/
    end
  end
end
