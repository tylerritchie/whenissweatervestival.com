require 'date'
require 'mustache'

class Index < Mustache
  self.path = File.dirname(__FILE__)

  def current_sweatervestival_date
    @_sweatervestival_date ||= if current_date <= current_year_sweatervestival_date 
      current_year_sweatervestival_date
    else
      next_year_sweatervestival_date
    end
  end

  def current_sweatervestival_date_formatted
    current_sweatervestival_date.strftime('%A %B %-d, %Y')
  end

  private

    def current_date
      @_current_date ||= Date.today
    end

    def current_year
      current_date.year
    end

    def current_year_sweatervestival_date
      sweatervestival_date(year: current_year)
    end

    def next_year_sweatervestival_date
      sweatervestival_date(year: current_year + 1)
    end

    def sweatervestival_date(year:)
      thanksgiving_date(year: year) + 8
    end

    def thanksgiving_date(year:)
      last_thursday(year: year, month: 11)
    end

    def last_thursday(year:, month:)
      last_day = Date.new(year, month, -1)
      day_of_week = last_day.wday

      last_day - ((day_of_week - 4) % 7)
    end
end

puts Index.render if $0 == __FILE__
