require 'log_parser'

class SortedLogStatsExtractor
  def process(filename = "")
    begin
      contents = load_file_contents(filename)
      LogParser.new.parse(contents)
    rescue Exception => e
      puts "There was an error parsing the file contents: #{e.message}"
      return nil
    end
  end

  protected

  # TODO: We should extract this into a DataSource object or something like that.
  # This would give the ability to set different data sources
  def load_file_contents(filename)
    File.open(filename).readlines
  end
end