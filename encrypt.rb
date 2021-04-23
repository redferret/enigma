require './lib/enigma'
require 'date'

require './lib/validatable'

puts "Press Return to quit the program\n\nEnter the following to Encrypt a message"
puts "<path to file to encrypt> <path to write enrypted message> <key> <date>"
puts '- keys are five digits with padded zeros `09876`'
puts '- dates are formatted as MMDDYY'

loop do
  print '>'
  input = gets.chomp
  break if input == ''
  arguments = input.split(' ')
  puts "Invalid arguments provided\n" if not(Validatable.arguments_are_valid? arguments)
  find_error(arguments) if not(Validatable.arguments_are_valid? arguments)
end
