require './lib/enigma'

def valid_date?(date)
  /\d{6}/.match? date
end

def valid_key?(key)
  /\d{5}/.match? key
end

def valid_number_of_arguments?(args)
  args.length == 4
end

def arguments_are_valid(arguments)
  date = arguments[3]
  key = arguments[2]
  return valid_date?(date) && valid_key?(key) && valid_number_of_arguments?(arguments)
end

def find_error(arguments)
  wrong_number_of_arguments = not(valid_number_of_arguments? arguments)
  puts '- Wrong number of arguments given' if wrong_number_of_arguments
  return if wrong_number_of_arguments

  date = arguments[3]
  key = arguments[2]
  puts '- Invalid date entered' if not(valid_date? date)
  puts '- Invalid key given' if not(valid_key? key)
end

puts "Press Return to quit the program\n\nEnter the following to Encrypt a message"
puts "<path to file to encrypt> <path to write enrypted message> <key> <date>"
puts '- keys are five digits with padded zeros `09876`'
puts '- dates are formatted as MMDDYY'
loop do
  print '>'
  input = gets.chomp
  break if input == ''
  arguments = input.split(' ')

  break if arguments_are_valid(arguments)
  puts "Invalid arguments provided\n"
  find_error(arguments)
end
