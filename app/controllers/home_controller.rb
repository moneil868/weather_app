class HomeController < ApplicationController

  def index
  end

  def search
    @resultsArray = []
    @city = params[:city]
    @cityEmpty = params[:city].blank?

    if !@cityEmpty
      @Open_Weather_Response = 
        HTTParty.get(
          "http://api.openweathermap.org/data/2.5/weather?q=#{@city}&APPID=#{ENV['OPEN_WEATHER_APP_API_KEY']}&units=metric"
        )

      #APIXU Weather API https://www.apixu.com 
      @APIXU_Response =
        HTTParty.get(
          "http://api.apixu.com/v1/current.json?q=#{@city}&key=#{ENV['APIXU_API_KEY']}"
        )

      #World Weather Online API https://www.worldweatheronline.com 
      @WORLD_WEATHER_Response =
        HTTParty.get(
          "http://api.worldweatheronline.com/premium/v1/weather.ashx?key=#{ENV['WORLD_WEATHER_API_KEY']}&q=#{@city}&num_of_days=1&format=json"
        )

      #identity country by world bank country code
      if @APIXU_Response.response.code == "200"
        @country = @APIXU_Response["location"]["country"]
        p @country
      end

    end

    @results = @resultsArray

    respond_to do |format|
      format.js
    end
  end
end

