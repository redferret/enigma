require './lib/enigma'
require 'date'

require './lib/validatable'

arguments = ARGV
arg_length = arguments.length
error_type = Validatable.find_errors(arguments)

begin
  if error_type.length > 0
    error_type.each do |error|
      case error
        when :file_not_found
          raise ArgumentError, '- Encryption file not found'
        when :wrong_arg_length
          if arg_length > 2
            raise ArgumentError, '- Wrong number of arguments given, expected 2'
          end
      end
    end
  end
  
rescue ArgumentError => e
  puts e.message
end
