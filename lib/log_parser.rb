require 'log_visits_result'

class LogParser
  def parse(contents)
    contents.each do |entry|
      result_set.add(*parse_entry(entry))
    end
    result_set
  end

  protected

  def result_set
    @_result_set ||= LogVisitsResult.new
  end

  def parse_entry(entry)
    entry.split(" ")
  end
end