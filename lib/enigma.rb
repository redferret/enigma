require 'date'
require 'pry'

require './lib/keyable'

class Enigma
  include Keyable

  def initialize
    @character_set = ("a".."z").to_a << " " << "\n"
  end

  def encrypt(message, key = generate_key, date = current_date)
    process_message(message, key, date)
  end

  def decrypt(message, key, date = current_date)
    process_message(message.chomp, key, date, false)
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
      ordinal = convert_to_ordinal(msg_char)
      shift = ordinal + offset if encrypt
      shift = ordinal - offset if not encrypt
      new_char = rotate(shift)
      new_message << new_char
    end

    return {
      encryption: encrypted_message.join,
      key: key,
      date: date
    }
  end

  def rotate(shift)
    new_char_index = shift % @character_set.length
    @character_set[new_char_index]
  end

  def convert_to_ordinal(char)
    case char
      when ' '
        return 26
      when "\n"
        return 27
    end
    char.ord - 97
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

  def get_year_from_time(time)
    full_time_str = time.to_s
    full_time_as_arr = full_time_str.split(' ')
    time_str = full_time_as_arr.first
  end

  def current_date
    time = Time.now
    time_str = get_year_from_time(time)
    date = Date.strptime(time_str)
    date.strftime('%d%m%y')
  end
end
