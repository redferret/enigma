require 'rspec'
require './lib/io_decrypt'

RSpec.describe Io_Decrypt do
  describe '#new' do
    it 'tests that Io_Decrypt exists' do
      io_decrypt = Io_Decrypt.new
      expect(io_decrypt).is_a? Io_Decrypt
    end
  end
end
