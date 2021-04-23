require 'rspec'
require './lib/enigmaIo'

RSpec.describe EnigmaIo do
  describe '#new' do
    it 'tests that EnigmaIo exists' do
      enigmaIo = Enigmaio.new
      expect(enigmaIO).is_a? EnigmaIo
    end
  end
end
