require 'date'

class Enigma
  def initialize
    @character_set = ("a".."z").to_a << " "
  end


  def generate_keys(from_key)
    key_chars = from_key.chars
    keys = []
    key_chars.each_cons(2) do |pair|
      keys << pair.join('')
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
