class TimeFormatter

  FORMATS = { 'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S' }.freeze

    def initialize(str)
      str.slice!('format=')
      @str = str
      @arr_correct = []
      @arr_not_correct = []
      conversion
    end

    def correct?
      @arr_not_correct.empty?
    end

    def incorrect_data
      @arr_not_correct
    end

    def get_time
      Time.now.strftime(prepared_string)
    end
  
    private

    def prepared_string
      @arr_correct.join('-')
    end

    def spliting
      @str.split('%')
    end

    def conversion
      spliting.each do |el|
        if FORMATS[el]
          @arr_correct << FORMATS[el]
        else
          @arr_not_correct << el
        end
      end      
    end
end
