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
      fourth_thursday(year: year, month: 11)
    end

    def fourth_thursday(year:, month:)
      first_thursday(year: year, month: month) + 7*3
    end
    
    def first_thursday(year:, month:)
      first_day = Date.new(year, month, 1)

      # sundays are 0
      if (difference = 4 - first_day.wday) < 0
        first_day + 5 + (difference % 2)
      else
        first_day + difference
      end
    end

end

puts Index.render if $0 == __FILE__
