require 'rspec'
require './lib/io_encrypt'

RSpec.describe Io_Encrypt do
  describe '#new' do
    it 'tests that Io_Encrypt exists' do
      io_encrypt = Io_Encrypt.new
      expect(io_encrypt).is_a? Io_Encrypt
    end
  end
end
