module Validatable
  extend self

  def valid_date?(date)
    begin
      Date.strptime(date, '%d%m%y')
      return /\b\d{6}\b/.match? date
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
        return file_exists?(arguments[0])
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
    errors = []
    wrong_number_of_arguments = not(valid_number_of_arguments? arguments)
    return (errors << :wrong_arg_length) if wrong_number_of_arguments
    return if wrong_number_of_arguments

    arg_length = arguments.length
    file_name = arguments[0]

    errors << :file_not_found if not(file_exists?(file_name))

    if arg_length == 3
      key = arguments[2]
      date = arguments[2]
      errors << :invalid_key_given if not(valid_key? key)
      errors << :invalid_date_given if not(valid_date? date)
    else
      key = arguments[2]
      date = arguments[3]
      errors << :invalid_key_given if not(valid_key? key)
      errors << :invalid_date_given if not(valid_date? date)
    end
    return errors
  end
end
