require 'rspec'
require './lib/validation'
require './lib/iocrypt'

RSpec.describe Validation do
  describe '#valid_date?' do
    it 'returns true if a valid date is given' do
      test_date = '091220'
      expect(Validation.valid_date?(test_date)).to eq true
    end

    it 'returns false if an invalid date is given' do
      first_test_date = '991220'
      second_test_date = '213'

      expect(Validation.valid_date?(first_test_date)).to eq false
      expect(Validation.valid_date?(second_test_date)).to eq false
    end
  end

  describe '#valid_key?' do
    it 'returns true is a valid key is given' do
      test_key = '03432'
      expect(Validation.valid_key?(test_key)).to eq true
    end

    it 'returns false is an invalid key is given' do
      first_test_key = '991220'
      second_test_key = '213'

      expect(Validation.valid_key?(first_test_key)).to eq false
      expect(Validation.valid_key?(second_test_key)).to eq false
    end
  end

  describe '#find_errors' do
    it 'returns errors for an invalid key given' do
      allow(IoCrypt).to receive(:file_exists?).and_return(true)
      allow(Validation).to receive(:valid_date?).and_return(true)
      allow(Validation).to receive(:valid_key?).and_return(false)

      dummy_args = [0,0,0,0]
      errors = Validation.find_errors(dummy_args)

      expect(errors).to eq [:invalid_key_given]
    end

    it 'returns errors for an invalid date given' do
      allow(IoCrypt).to receive(:file_exists?).and_return(true)
      allow(Validation).to receive(:valid_date?).and_return(false)
      allow(Validation).to receive(:valid_key?).and_return(true)

      dummy_args = [0,0,0,0]
      errors = Validation.find_errors(dummy_args)

      expect(errors).to eq [:invalid_date_given]
    end

    it 'returns errors for an invalid key and date given' do
      allow(IoCrypt).to receive(:file_exists?).and_return(true)
      allow(Validation).to receive(:valid_date?).and_return(false)
      allow(Validation).to receive(:valid_key?).and_return(false)

      dummy_args = [0,0,0,0]
      errors = Validation.find_errors(dummy_args)

      expect(errors).to eq [:invalid_key_given, :invalid_date_given]
    end

    it 'returns errors for an invalid number of args' do
      allow(IoCrypt).to receive(:file_exists?).and_return(true)
      allow(Validation).to receive(:valid_date?).and_return(false)


      dummy_args = []
      errors = Validation.find_errors(dummy_args, 4)

      expect(errors.include?(:wrong_arg_length)).to eq true
    end

    it 'returns errors for file not existing' do
      allow(IoCrypt).to receive(:file_exists?).and_return(false)

      file_name = './test_file'
      dummy_args = [file_name]
      errors = Validation.find_errors(dummy_args, 1)

      expect(errors).to eq [:file_not_found]
    end
  end
end
