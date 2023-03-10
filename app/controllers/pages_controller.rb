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
        "âī¸"
      when 1..3
        "â"
      when 45..48
        "đĢī¸ "
      when 51..67
        "đ§ī¸"
      when 71..77
        "đ¨ī¸"
      when 80..82
        "đ§ī¸"
      when 85..86
        "đ¨ī¸"
      when 95..99
        "đŠī¸"
      else
        "Error: no weather code provided or weather code is not assigned an icon"
    end

  end

end