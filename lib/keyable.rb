module Keyable
  def offset_keys(array1, array2)
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
    random_number = get_random_number(99999).to_s
    if not_a_valid_key?(random_number)
      diff = 5 - random_number.length
      padding = ""
      diff.times do
        padding << '0'
      end
      return "#{padding}#{random_number}"
    end
    random_number
  end

  def not_a_valid_key?(key)
    not (/\b\d{5}\b/.match? key)
  end

  def get_random_number(range)
    rand(range)
  end
end
