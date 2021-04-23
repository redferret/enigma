require 'rspec'
require './lib/Cypher'

RSpec.describe Cypher do
  describe '#new' do
    it 'tests that Cypher exists' do
      cypher = Cypher.new
      expect(cypher).is_a? Cypher
    end
  end
end
