require 'date'
require 'pry'

require './lib/keyable'

class Enigma
  include Keyable

  def initialize
    @character_set = ("a".."z").to_a << " "
  end

  def encrypt(message, key = generate_key, date = current_date)
    process_message(message, key, date)
  end

  def decrypt(message, key, date = current_date)
    process_message(message, key, date, false)
  end

  def process_message(message, key, date, encrypt = true)
    offsets = offsets(date)
    keys = generate_keys(key)
    key_offsets = offset_keys(offsets, keys)
    downcase_message = message.downcase.chars
    counter = 0
    encrypted_message = downcase_message.each_with_object([]) do |msg_char, new_message|
      offset = key_offsets[counter % 4]
      counter += 1
      if msg_char != "\n"
        ordinal = convert_to_ordinal(msg_char)
        shift = ordinal + offset if encrypt
        shift = ordinal - offset if not encrypt
        new_char = @character_set[shift % 27]
        new_message << new_char
      else
        new_message << '\n'
      end
      new_message
    end

    return {
      encryption: encrypted_message.join,
      key: key,
      date: date
    }
  end

  def convert_to_ordinal(char)
    (char == ' ')? 26 : char.ord - 97
  end

  def offsets(date)
    numeric = date.to_i
    sqr_num = numeric**2
    str_num = sqr_num.to_s
    digits = str_num[-4..-1].chars
    digits.map do |char|
      char.to_i
    end
  end

  def current_date
    time = Time.now
    full_time_str = time.to_s
    full_time_as_arr = full_time_str.split(' ')
    time_str = full_time_as_arr.first

    date = Date.strptime(time_str)
    date.strftime('%d%m%y')
  end
end
