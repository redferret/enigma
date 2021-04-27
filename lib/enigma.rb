require './lib/keyable'
require './lib/dateable'

class Enigma
  include Keyable

  def initialize
    @rotor = ("a".."z").to_a << " "
  end

  def encrypt(message, key = generate_key, date = formatted_date)
    process_message(message, key, date)
  end

  def decrypt(message, key, date)
    process_message(message, key, date, false)
  end

  def process_message(message, key, date, encrypt = true)
    key_offsets = make_key_offsets(key, date)
    downcase_message = message.downcase.chars

    encrypted_message = downcase_message.each_with_object([]) do |msg_char, new_message|
      new_message << get_encrypted_character(key_offsets, msg_char, encrypt)
    end

    return {
      encryption: encrypted_message.join,
      key: key,
      date: date
    }
  end

  def make_key_offsets(key, date)
    offsets = offsets(date)
    keys = generate_keys(key)
    sum_the_keys(offsets, keys)
  end

  def get_encrypted_character(key_offsets, msg_char, encrypt)
    offset = key_offsets.first
    key_offsets.rotate!

    if character_is_cryptable?(msg_char)
      shift = get_shift(msg_char, offset, encrypt)
      return rotate(shift)
    else
      return msg_char
    end
  end

  def get_shift(msg_char, offset, encrypt)
    ordinal = convert_to_ordinal(msg_char)
    return ordinal + offset if encrypt
    return ordinal - offset if not encrypt
  end

  def character_is_cryptable?(char)
    (character_is_alpha?(char) || char_is_a_space(char))
  end

  def character_is_alpha?(char)
    (char.ord > 96 && char.ord < 123)
  end

  def rotate(shift)
    spin = shift % @rotor.length
    @rotor[spin]
  end

  def convert_to_ordinal(char)
    return 26 if char_is_a_space(char)
    char.ord - 97
  end

  def char_is_a_space(char)
    char == ' '
  end

  def offsets(date)
    numeric = date.to_i
    sqr_num = numeric**2
    str_num = sqr_num.to_s
    last_four_digits = str_num[-4..-1].chars
    last_four_digits.map do |char|
      char.to_i
    end
  end

  def formatted_date
    date = Dateable.current_date
    Dateable.reformat_date(date, '%d%m%y')
  end
end
