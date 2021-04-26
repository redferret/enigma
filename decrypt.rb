require 'date'

require './lib/enigma'
require './lib/iocrypt'
require './lib/validable'

arguments = ARGV
arg_length = arguments.length

enigma = Enigma.new
error_type = Validable.find_errors(arguments)

begin
  if error_type.length > 0
    messages = ""
    error_type.each do |error|
      case error
        when :file_not_found
          messages << "- Message file not found\n"
        when :wrong_arg_length
          messages << "- Wrong number of arguments given, expected 4\n"
        when :invalid_key_given
          messages << "- Invalid key given\n"
        when :invalid_date_given
          messages << "- Invalid date given\n"
      end
    end
    raise ArgumentError, messages
  end

  in_file = arguments[0]
  out_file = arguments[1]
  key = arguments[2]
  date = arguments[3]
  decrypt_io = IoCrypt.new(in_file, out_file)
  message = decrypt_io.process_message
  result = enigma.decrypt(message, key, date)
  decrypt_io.write_message_to_file(result[:encryption])

  puts "Created '#{out_file}' with the key #{result[:key]} and date #{result[:date]}"
rescue ArgumentError => e
  puts e.message
end
