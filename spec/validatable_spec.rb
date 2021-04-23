require 'rspec'
require './lib/validatable'

RSpec.describe Validatable do
  describe '#new' do
    it 'tests that Validatable exists' do
      validatable = Validatable.new
      expect(validatable).is_a? Validatable
    end
  end
end
