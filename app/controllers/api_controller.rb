require 'open-uri'
require 'json'

class ApiController < ApplicationController
  def weather_form
  end

  def weather_output
    address = URI.encode(params["address"])
    url = "http://api.openweathermap.org/data/2.5/weather?q=#{address}"
    initial_info = open(url).read
    parsed_info = JSON.parse(initial_info)
    @result = parsed_info["weather"][0]["main"]
    @icon = parsed_info["weather"][0]["icon"]
    @latitude = parsed_info["coord"]["lat"]
    @longitude = parsed_info["coord"]["lon"]
    @wind_speed = parsed_info["wind"]["speed"]
    @wind_direction = parsed_info["wind"]["deg"]
    max_temp = parsed_info["main"]["temp_max"]
    @max_temperature = (max_temp - 273.15)*1.8 + 32
    min_temp = parsed_info["main"]["temp_min"]
    @min_temperature = (min_temp - 273.15)*1.8 + 32
  end
end
