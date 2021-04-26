class IoCrypt
  def initialize(from_file_name, to_file_name)
    @file_in = open_file(from_file_name)
    @file_out = open_file(to_file_name, 'w')
  end

  def open_file(file_name, option = 'r')
    if not file_name.include?('./')
      File.new("./#{file_name}", option)
    else
      File.new(file_name, option)
    end
  end

  def process_message
    lines = lines_from_file
    lines.reduce('') do |message, line|
      message + line
    end.chomp
  end

  def write_message_to_file(message)
    lines = message.split('\n')
    lines.each do |line|
      write_line_to(@file_out, line)
    end
  end

  def self.file_exists?(file_name)
    File.exist?(file_name)
  end

  private
  def write_line_to(file, line)
    @file_out.puts(line)
  end
  def lines_from_file
    @file_in.readlines
  end
end
