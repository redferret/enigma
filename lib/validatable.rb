module Validatable
  extend self

  def valid_date?(date)
    begin
      Date.strptime(date, '%d%m%y')
    rescue ArgumentError
      return false
    end
    return true
  end

  def valid_key?(key)
    /\b\d{5}\b/.match? key
  end

  def valid_number_of_arguments?(args)
    args.length >= 2 && args.length < 5
  end

  def arguments_are_valid?(arguments)
    if valid_number_of_arguments?(arguments)
      arg_length = arguments.length
      if arg_length == 2
        # files only
        return true
      elsif arg_length == 3
        return valid_key?(arguments[2])
      elsif arg_length == 4
        return valid_key?(arguments[2]) && valid_date?(arguments[3])
      end
    end
    return false
  end

  def file_exists?(file_name)
    File.exist?(file_name)
  end

  def find_error(arguments)
    wrong_number_of_arguments = not(valid_number_of_arguments? arguments)
    puts '- Wrong number of arguments given' if wrong_number_of_arguments
    return if wrong_number_of_arguments

    arg_length = arguments.length
    file_name = arguments[0]

    puts "- File not found #{file_name}" if not(file_exists?(file_name))

    if arg_length == 4
      key = arguments[2]
      date = arguments[3]
      puts '- Invalid key given' if not(valid_key? key)
      puts '- Invalid date given' if not(valid_date? date)
    elsif arg_length == 3
      key = arguments[2]
      puts '- Invalid key given' if not(valid_key? key)
    end
  end
end