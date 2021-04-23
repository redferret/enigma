module Validatable
  extend self
  def valid_date?(date)
    return (/\d{6}/.match? date) && check_date(date)
  end

  def check_date(date)
    begin
      Date.strptime(date, '%d%m%y')
    rescue ArgumentError
      return false
    end
    return true
  end

  def valid_key?(key)
    /\d{5}/.match? key
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

  def find_error(arguments)
    wrong_number_of_arguments = not(valid_number_of_arguments? arguments)
    puts '- Wrong number of arguments given' if wrong_number_of_arguments
    return if wrong_number_of_arguments

    arg_length = arguments.length
    if arg_length == 2
      # files only
      return true
    elsif arg_length == 4
      puts '- Invalid key given' if not(valid_key? arguments[2])
      puts '- Invalid date entered' if not(valid_date? arguments[3])
    elsif arg_length == 3
      puts '- Invalid key given' if not(valid_key? arguments[2])
    end
  end
end
