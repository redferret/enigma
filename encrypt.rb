require './lib/enigma'
require 'date'

require './lib/validatable'

arguments = ARGV
arg_length = arguments.length
error_type = Validatable.find_errors(arguments)

if error_type.length > 0
  case error_type.length
    when 1
      error = error_type.first
      if error == :file_not_found
        puts "  - file not found #{arguments[0]}"
      elsif error == :wrong_arg_length && (arg_length < 2 || arg_length > 4)
        puts "  - Wrong number of arguments given #{arg_length}, expected 2, 3, or 4"
      end
      puts '  - 2 args are valid to use'
    when 2
      error = error_type.first
      if error == :file_not_found
        puts "  - file not found #{arguments[0]}"
      elsif error == :wrong_arg_length && (arg_length < 2 || arg_length > 4)
        puts "  - Wrong number of arguments given #{arg_length}, expected 2, 3, or 4"
      end

      if arg_length == 3
        if error == :invalid_date_given
          # if only :invalid_date_given was returned
          # then this is a valid key
          puts '  - 3 args found with a good key'
        elsif error == :invalid_key_given
          # if only an :invalid_key_given was returned
          # then this is a valid date
          puts '  - 3 args found with a good date'
        end
      elsif arg_length == 4
        if error == :invalid_key_given
          puts ' - Invalid key was given (expected format #####, # - a digit (0-9)) A'
        end
        if error == :invalid_date_given
          puts ' - Invalid date was given (expected format DDMMYY)'
        end
      end
    when 3
      error = error_type.first
      if error == :file_not_found
        puts "  - file not found #{arguments[0]}"
      elsif error == :wrong_arg_length && (arg_length < 2 || arg_length > 4)
        puts "  - Wrong number of arguments given #{arg_length}, expected 2, 3, or 4"
      end

      if arg_length == 3
        if error == :invalid_date_given
          puts '  - Invalid date given'
        elsif error == :invalid_key_given
          puts '  - Invalid key given'
        else
      elsif arg_length == 4
        puts ' - Invalid date or key was given'
      end
      puts '(expected format #####, # - a digit (0-9) for keys and expected format DDMMYY for dates)'
  end
else
  puts '  - 4 args found as good'
end
