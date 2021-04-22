class Enigma
  def initialize
    @character_set = ("a".."z").to_a << " "
  end


  def generate_key
    random_number = random(99999)
    if random_number < 10000
      # add padding
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

  private
  def random(range)
    rand(range)
  end