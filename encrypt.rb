require './lib/enigma'
require 'date'

require './lib/validatable'

puts "Press Return to quit the program\n\n"
puts 'Enter the following to Encrypt a message (date and/or key are optional)'
puts '<path to file to encrypt> <path to write enrypted message> <key> <date>'
puts '- keys are five digits with padded zeros `09876`'
puts '- dates are formatted as DDMMYY'

loop do
  print '>'
  input = gets.chomp
  break if input == ''
  arguments = input.split(' ')
  arg_length = arguments.length
  error_type = Validatable.find_errors(arguments)
  if error_type.length > 0
    case error_type.length
      when 1
        error = error_type.first
        if error == :file_not_found
          puts "  - file not found #{arguments[0]}"
        elsif error == :wrong_arg_length
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
          else
            puts ' - Invalid date or key given in 3rd argument'
          end
        else
          if error == :invalid_key_given
            puts ' - Invalid key was given (expected format #####, # - a digit (0-9))'
          elsif error == :invalid_date_given
            puts ' - Invalid date was given (expected format DDMMYY)'
          end
        end
      when 2
        error = error_type.first
        if arg_length == 3
          puts ' - Invalid date or key given in 3rd argument'
        else
          puts ' - Invalid key and date was given'
        end
        puts '(expected format #####, # - a digit (0-9) for keys and expected format DDMMYY for dates)'
    end
  else
    if arg_length == 2
      puts '  - 2 args are valid to use'
    else
      puts '  - 4 args are valid to use'
    end
  end
end
