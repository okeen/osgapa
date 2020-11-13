class LogVisitsResult
  def add(path = '', ip = '')
    return if path == nil || path == '' || ip == nil || ip == ''
    visits[path] ||= Hash.new { 0 }
    visits[path][ip] += 1
  end

  def visits
    @_visits ||= {}
  end

  def to_a(unique = false)
    sort_by_unique_visits(
        visits.map { |path, visits| unique ? unique_result_item(path, visits) : result_item(path, visits) }
    )
  end

  protected

  def unique_result_item(path, visits)
    [path, visits.keys.count]
  end

  def result_item(path, visits)
    [path, visits.values.inject(:+)]
  end

  def sort_by_unique_visits(a_list)
    Array(a_list).sort { |a, b| a.last <=> b.last }.reverse
  end
end