require 'rspec'
require './lib/io_crypt'

RSpec.describe Io_Crypt do
  describe '#new' do
    it 'tests that Io_Crypt exists' do
      io_crypt = Io_Crypt.new
      expect(io_crypt).is_a? Io_Crypt
    end
  end
end
