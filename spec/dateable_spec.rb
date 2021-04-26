require 'rspec'

require './lib/dateable'

describe Dateable do
  describe '#reformat_date' do
    it 'reformats a date from Time to a new format DDMMYY' do
      actual_date = Dateable.reformat_date('2021-07-29', '%d%m%y')
      expect(actual_date).to eq '290721'
    end
  end

  describe('#current_date') do
    it 'gets the first part of the current Time object as a string' do
      actual_date = Dateable.current_date
      expect(actual_date).to match /\d{4}-\d{2}-\d{2}/
    end
  end
end
