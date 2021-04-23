require './lib/enigma'
require 'date'

require './lib/validatable'

puts "Press Return to quit the program\n\n"
puts "Enter the following to Encrypt a message (date and/or key are optional)"
puts "<path to file to encrypt> <path to write enrypted message> <key> <date>"
puts '- keys are five digits with padded zeros `09876`'
puts '- dates are formatted as MMDDYY'

loop do
  print '>'
  input = gets.chomp
  break if input == ''
  arguments = input.split(' ')
  arg_length = arguments.length
  if not(Validatable.arguments_are_valid? arguments)
    error_type = find_error(arguments)

    case error_type.length
      when 1
        error = error_type.first
        if error == :file_not_found
          puts "- file not found #{arguments[0]}"
        elsif error == :wrong_arg_length
          puts "- Wrong number of arguments given #{arg_length}, expected 2, 3, or 4"
        end

        if arg_length == 3
          if error == :invalid_key_given
            # if only an :invalid_key_given was returned
            # then this is a valid date
            puts 'I am pretending to do something with just a date'
          else
            # if only :invalid_date_given was returned
            # then this is a valid key
            puts 'I am pretending to do something with just a key'
          end
        end
      when 2
        puts "- Invalid date was given (expected format DDMMYY)"
        puts '- Invalid key was given (expected format #####, # - a digit (0-9))'
    end
  else
    puts 'I am pretending to do something with a key and date'
  end
end
