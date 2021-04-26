require 'rspec'
require './lib/iocrypt'

RSpec.describe IoCrypt do
  let(:mock_iocrypt) do
    @mock_file = instance_double('File')
    allow_any_instance_of(IoCrypt).to receive(:open_file).and_return(@mock_file)
    allow_any_instance_of(IoCrypt).to receive(:lines_from_message).and_return(['line1', 'line2'])
    mock_iocrypt = IoCrypt.new('fake file', 'fake file')
  end
  describe '#new' do
    it 'tests that IoCrypt exists' do
      expect(mock_iocrypt).to be_an IoCrypt
    end
  end

  describe '#open_file' do
    it 'opens a file with default read option' do
      allow(File).to receive(:new)
      iocrypt = IoCrypt.new('fake_file', 'fake_file')
      expect(File).to have_received(:new).with("./fake_file", anything).twice
    end
  end

  describe '#process_message' do
    it 'reads lines from file and merges them into one string' do
      actual = mock_iocrypt.process_message
      expected = 'line1line2'

      expect(actual).to eq expected
    end
  end

  describe '#write_message_to_file' do
    it 'writes a message to file' do
      allow(mock_iocrypt).to receive(:write_line_to)
      mock_iocrypt.write_message_to_file('message\nnew line')
      expect(mock_iocrypt).to have_received(:write_line_to).twice
    end
  end

  describe '#file_exists?' do
    it 'calls exist? on File' do
      allow(File).to receive(:exist?).with(instance_of String).and_return(true)
      response = IoCrypt.file_exists?('fake_file_name')

      expect(File).to have_received(:exist?)
      expect(response).to eq true
    end
  end
end
