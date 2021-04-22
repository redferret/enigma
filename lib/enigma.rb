require 'date'

class Enigma
  def initialize
    @character_set = ("a".."z").to_a << " "
  end

  def encrypt(message, key = generate_key, date = current_date)
    offsets = offsets(date)
    keys = generate_keys(key)
    key_offsets = letter_key_offsets(offsets, keys)

    counter = 0
    encrypted_message = message.chars.each_with_object('') do |msg_char, encrypted_message|
      shift = key_offsets[counter]
      counter += 1
      ordinal = (msg_char.ord - 97)
      new_char = @character_set[ordinal + shift]
      encrypted_message += new_char
    end

    return {
      encryption: encrypted_message,
      key: key,
      date: date
    }
  end

  def letter_key_offsets(array1, array2)
    to_sum = [array1, array2]
    to_sum.transpose.map(&:sum)
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

  def generate_keys(from_key)
    key_chars = from_key.chars
    keys = []
    key_chars.each_cons(2) do |pair|
      keys << pair.join('').to_i
    end
    keys
  end

  def generate_key
    random_number = random(99999)
    if random_number < 10000
      random_number_as_s = random_number.to_s
      diff = 5 - random_number_as_s.length
      padding = ""
      diff.times do
        padding << '0'
      end
      return "#{padding}#{random_number_as_s}"
    end
    random_number.to_s
  end

  def current_date
    time = Time.now
    full_time_str = time.to_s
    full_time_as_arr = full_time_str.split(' ')
    time_str = full_time_as_arr.first

    date = Date.strptime(time_str)
    date.strftime('%d%m%y')
  end

  private
  def random(range)
    rand(range)
  end
end
