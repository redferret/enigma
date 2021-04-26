require 'date'

module Dateable
  extend self
  def current_date
    time = Time.now
    full_time_str = time.to_s
    full_time_as_arr = full_time_str.split(' ')
    time_str = full_time_as_arr.first
  end

  def reformat_date(date, format)
    date = Date.strptime(date)
    date.strftime('%d%m%y')
  end
end
