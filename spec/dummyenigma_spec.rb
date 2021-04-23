require 'rspec'
require './lib/dummyenigma'

RSpec.describe Dummyenigma do
  describe '#new' do
    it 'tests that Dummyenigma exists' do
      dummyenigma = Dummyenigma.new
      expect(dummyenigma).is_a? Dummyenigma
    end
  end
end
