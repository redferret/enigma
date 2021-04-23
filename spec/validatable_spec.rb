require 'rspec'
require './lib/validatable'

RSpec.describe Validatable do

  describe '#file_exists?' do
    it 'calls exist? on File' do
      allow(File).to receive(:exist?).with(instance_of String).and_return(true)

      Validatable.file_exists?('fake_file_name')

      expect(File).to have_received(:exist?)
    end
  end

  describe '#valid_date?' do
    it 'returns true if a valid date is given' do
      test_date = '091220'
      expect(Validatable.valid_date?(test_date)).to eq true
    end

    it 'returns false if an invalid date is given' do
      first_test_date = '991220'
      second_test_date = '213'

      expect(Validatable.valid_date?(first_test_date)).to eq false
      expect(Validatable.valid_date?(second_test_date)).to eq false
    end
  end

  describe '#valid_key?' do
    it 'returns true is a valid key is given' do
      test_key = '03432'
      expect(Validatable.valid_key?(test_key)).to eq true
    end

    it 'returns false is an invalid key is given' do
      first_test_key = '991220'
      second_test_key = '213'

      expect(Validatable.valid_key?(first_test_key)).to eq false
      expect(Validatable.valid_key?(second_test_key)).to eq false
    end
  end

  describe '#valid_number_of_arguments?' do
    it 'returns true if number of arguments are 2, 3, or 4' do
      expect(Validatable.valid_number_of_arguments?([0,0])).to eq true
      expect(Validatable.valid_number_of_arguments?([0,0,0])).to eq true
      expect(Validatable.valid_number_of_arguments?([0,0,0,0])).to eq true
    end

    it 'returns false if number of arguments are not 2, 3, or 4' do
      allow(Validatable).to receive(:file_exists?)

      expect(Validatable.valid_number_of_arguments?([0])).to eq false
      expect(Validatable.valid_number_of_arguments?([0,0,0,0,0])).to eq false
    end
  end

  describe '#find_error' do
    it 'returns errors for an invalid key given' do
      allow(Validatable).to receive(:valid_number_of_arguments?).and_return(true)
      allow(Validatable).to receive(:file_exists?).and_return(true)
      allow(Validatable).to receive(:valid_date?).and_return(true)
      allow(Validatable).to receive(:valid_key?).and_return(false)

      dummy_args = [0,0,0,0]
      errors = Validatable.find_error(dummy_args)

      expect(errors).to eq [:invalid_key_given]
    end

    it 'Prints a message for an invalid date given' do
      allow(Validatable).to receive(:valid_number_of_arguments?).and_return(true)
      allow(Validatable).to receive(:file_exists?).and_return(true)
      allow(Validatable).to receive(:valid_date?).and_return(false)
      allow(Validatable).to receive(:valid_key?).and_return(true)

      dummy_args = [0,0,0,0]
      errors = Validatable.find_error(dummy_args)

      expect(errors).to eq [:invalid_date_given]
    end

    it 'Prints messages for an invalid key and date given' do
      allow(Validatable).to receive(:valid_number_of_arguments?).and_return(true)
      allow(Validatable).to receive(:file_exists?).and_return(true)
      allow(Validatable).to receive(:valid_date?).and_return(false)
      allow(Validatable).to receive(:valid_key?).and_return(false)

      dummy_args = [0,0,0,0]
      errors = Validatable.find_error(dummy_args)

      expect(errors).to eq [:invalid_key_given, :invalid_date_given]
    end

    it 'Prints messages for an invalid number of args' do
      allow(Validatable).to receive(:valid_number_of_arguments?).and_return(false)

      dummy_args = []
      errors = Validatable.find_error(dummy_args)

      expect(errors).to eq [:wrong_arg_length]
    end

    it 'Prints messages for file not existing' do
      allow(Validatable).to receive(:valid_number_of_arguments?).and_return(true)
      allow(Validatable).to receive(:file_exists?).and_return(false)

      file_name = './test_file'
      dummy_args = [file_name]
      errors = Validatable.find_error(dummy_args)

      expect(errors).to eq [:file_not_found]
    end
  end
end
