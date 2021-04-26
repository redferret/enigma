module Keyable
  def sum_the_keys(array1, array2)
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
    return add_padding(random_number) if not_a_valid_key?(random_number)
    random_number
  end

  def add_padding(number)
    diff = 5 - number.length
    padding = ""
    diff.times do
      padding << '0'
    end
    return "#{padding}#{number}"
  end

  def not_a_valid_key?(key)
    not (Keyable.valid_key?(key))
  end

  def self.valid_key?(key)
    /\b\d{5}\b/.match? key
  end

  def get_random_number(range)
    rand(range)
  end
end
