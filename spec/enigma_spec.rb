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
      enigma = Enigma.new
      allow(enigma).to receive(:character_is_cryptable?).and_return(true)
      allow(enigma).to receive(:make_key_offsets).and_return([3, 27, 73, 20])

      expected = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
      actual = enigma.encrypt('Hello World', '02715', '040895')

      expect(actual).to eq expected
    end

    it 'Encrypts text without a date or key' do
      enigma = Enigma.new
      allow(enigma).to receive(:character_is_cryptable?).and_return(true)
      allow(enigma).to receive(:make_key_offsets).and_return([3, 27, 73, 20])
      allow(enigma).to receive(:generate_key).and_return('02715')
      allow(enigma).to receive(:formatted_date).and_return('040895')

      expected = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
      actual = enigma.encrypt('Hello World')

      expect(actual).to eq expected
    end
  end

  describe '#decrypt' do
    it 'decrypts a message with given key and date' do
      enigma = Enigma.new
      allow(enigma).to receive(:character_is_cryptable?).and_return(true)
      allow(enigma).to receive(:make_key_offsets).and_return([3, 27, 73, 20])

      expected = {
        encryption: 'hello world',
        key: '02715',
        date: '040895'
      }
      actual = enigma.decrypt('keder ohulw', '02715', '040895')

      expect(actual).to eq expected
    end
  end

  describe '#character_is_cryptable?' do
    it 'returns true if the character is a lower case letter, a space, or a new line' do
      enigma = Enigma.new
      result = enigma.character_is_cryptable?('a')
      expect(result).to eq true
    end

    it 'returns false if it is any other character' do
      enigma = Enigma.new
      char_set = %w[! @ # $ % ^ & * ( ) _ + - = ` ~ : ; \" \' / ? < > | , .]
      char_set.each do |char|
        result = enigma.character_is_cryptable?(char)
        expect(result).to eq false
      end
    end
  end

  describe '#make_key_offsets' do
    it 'creates the key offsets for shifting' do
      enigma = Enigma.new

      allow(enigma).to receive(:offsets).and_return([1, 0, 2, 5])
      allow(enigma).to receive(:generate_keys).and_return([2, 27, 71, 15])

      actual = enigma.make_key_offsets('02715', '040895')

      expect(actual).to eq [3, 27, 73, 20]
    end
  end

  describe '#rotate' do
    it 'performs a shoft rotation of the character set' do
      enigma = Enigma.new
      char = enigma.rotate(121)
      expected_char = 'n'
      expect(char).to eq expected_char
    end
  end

  describe '#convert_to_ordinal' do
    it "converts a character to it's ordinal value" do
      enigma = Enigma.new

      expected = 7
      actual = enigma.convert_to_ordinal('h')

      expect(actual).to eq expected
    end

    it 'accounts for the space character to be 26' do
      enigma = Enigma.new
      expected = 26
      actual = enigma.convert_to_ordinal(' ')
      expect(actual).to eq expected
    end

    it 'accounts for the new line character to be 27' do
      enigma = Enigma.new
      expected = 27
      actual = enigma.convert_to_ordinal("\n")
      expect(actual).to eq expected
    end
  end

  describe '#offsets' do
    it 'creates the offsets for encryption' do
      enigma = Enigma.new

      expected = [1, 0, 2, 5]

      expect(enigma.offsets('040895')).to eq expected
    end
  end

  describe '#formatted_date' do
    it 'returns date in format DDMMYY' do
      enigma = Enigma.new
      allow(Dateable).to receive(:current_date).and_return('2021-07-12')
      actual_date = enigma.formatted_date

      expect(actual_date).to eq '120721'
    end
  end
end
