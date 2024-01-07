require_relative 'time_formatter'

class App

  def initialize
    @status = nil
    @headers = { }
    @body = []
  end

  def call(env)
    @env = env
    router
    [@status, @headers, @body]
  end

  private

  def time
    formatted_time = TimeFormatter.new(@env['QUERY_STRING'])

    if formatted_time.correct?
      @body << "#{formatted_time.get_time}"
      @status = 200
      @headers['content-type'] = 'text/plain'
    else
      @status = 400
      @headers['content-type'] = 'text/plain'
      @body <<"Unknown time format #{formatted_time.incorrect_data}"
    end
  end

  def router
    begin
      self.send(@env['REQUEST_PATH'][1..-1])
    rescue
      @status = 404
      @headers['content-type'] = 'text/plain'
      @body << "#{@env['REQUEST_PATH']} does not exist"
    end
  end

end
