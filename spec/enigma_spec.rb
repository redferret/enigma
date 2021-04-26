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

      allow(enigma).to receive(:offsets).and_return([1, 0, 2, 5])
      allow(enigma).to receive(:generate_keys).and_return([2, 27, 71, 15])
      allow(enigma).to receive(:offset_keys).and_return([3, 27, 73, 20])

      expected = {
        encryption: 'kdadrzlguku',
        key: '02715',
        date: '040895'
      }
      actual = enigma.encrypt('Hello World', '02715', '040895')

      expect(actual).to eq expected
    end

    it 'Encrypts text without a date or key' do
      enigma = Enigma.new

      allow(enigma).to receive(:offsets).and_return([1, 0, 2, 5])
      allow(enigma).to receive(:generate_keys).and_return([2, 27, 71, 15])
      allow(enigma).to receive(:offset_keys).and_return([3, 27, 73, 20])
      allow(enigma).to receive(:generate_key).and_return('02715')
      allow(enigma).to receive(:formatted_date).and_return('040895')

      expected = {
        encryption: 'kdadrzlguku',
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

      allow(enigma).to receive(:offsets).and_return([1, 0, 2, 5])
      allow(enigma).to receive(:generate_keys).and_return([2, 27, 71, 15])
      allow(enigma).to receive(:offset_keys).and_return([3, 27, 73, 20])

      expected = {
        encryption: 'hello world',
        key: '02715',
        date: '040895'
      }
      actual = enigma.decrypt('kdadrzlguku', '02715', '040895')

      expect(actual).to eq expected
    end

    it 'decrypts text without a date' do
      enigma = Enigma.new

      allow(enigma).to receive(:offsets).and_return([1, 0, 2, 5])
      allow(enigma).to receive(:generate_keys).and_return([2, 27, 71, 15])
      allow(enigma).to receive(:offset_keys).and_return([3, 27, 73, 20])
      allow(enigma).to receive(:formatted_date).and_return('040895')

      expected = {
        encryption: 'hello world',
        key: '02715',
        date: '040895'
      }
      actual = enigma.decrypt('kdadrzlguku', '02715')

      expect(actual).to eq expected
    end
  end

  describe '#rotate' do
    it 'performs a shoft rotation of the character set' do
      enigma = Enigma.new
      char = enigma.rotate(121)
      expected_char = 'j'
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
