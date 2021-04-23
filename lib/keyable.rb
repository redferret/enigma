module Keyable
  def letter_key_offsets(array1, array2)
    to_sum = [array1, array2]
    to_sum.transpose.map(&:sum)
  end

  def generate_keys(from_key)
    key_chars = from_key.chars
    keys = []
    key_chars.each_cons(2) do |pair|
      keys << pair.join.to_i
    end
    keys
  end

  def generate_key
    random_number = random(999..99999)
    if needs_padding?(random_number)
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

  def needs_padding?(number)
    number < 10000
  end
end
