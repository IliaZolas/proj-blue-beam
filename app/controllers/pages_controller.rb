class PagesController < ApplicationController
  require 'uri'
  require 'net/http'
  
  def home
    @lat = params[:lat] || 0
    @lon = params[:lon] || 0

    url = "https://api.open-meteo.com/v1/forecast?latitude=#{@lat}&longitude=#{@lon}&current_weather=true"
    uri = URI(url)
    res = Net::HTTP.get_response(uri)

    @object = JSON.parse(res.body)

    puts res.body

    @temperature = @object["current_weather"]["temperature"]
    @weathercode = @object["current_weather"]["weathercode"]

    @icon = case @weathercode
      when 0
        "☀️"
      when 1..3
        "⛅"
      when 45..48
        "🌫️ "
      when 51..67
        "🌧️"
      when 71..77
        "🌨️"
      when 80..82
        "🌧️"
      when 85..86
        "🌨️"
      when 95..99
        "🌩️"
      else
        "Error: no weather code provided or weather code is not assigned an icon"
    end

  end

end