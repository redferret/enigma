require './lib/keyable'

module Validable
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

  def find_errors(arguments, expected_arg_length = 4)
    errors = []
    wrong_number_of_arguments = arguments.length != expected_arg_length
    errors << :wrong_arg_length if wrong_number_of_arguments

    arg_length = arguments.length
    file_name = arguments[0]

    return (errors << :file_not_found) if not(IoCrypt.file_exists?(file_name))

    if arg_length == 4
      key = arguments[2]
      date = arguments[3]
      errors << :invalid_key_given if not(Keyable.valid_key?(key))
      errors << :invalid_date_given if not(valid_date? date)
    end
    return errors
  end
end
