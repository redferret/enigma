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
    error_type.each do |error|
      case error
        when :file_not_found
          raise ArgumentError, '- Message file not found'
        when :wrong_arg_length
          raise ArgumentError, '- Wrong number of arguments given, expected 4'
      end
    end
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
