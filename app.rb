require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
forecast= ForecastIO.api_key = "30e771bb0f7be4c70e1feacd0eee6882"

get "/" do
# getting the location using ask.erb
 view "ask"
 end

get "/news" do
    @location = params["qlocation"]
    @geocoder_results = Geocoder.search(@location)
    @lat_long = @geocoder_results.first.coordinates # => [lat, long] array
    @forecast = ForecastIO.forecast(@lat_long[0],@lat_long[1]).to_hash
    #"#{@forecast}"
 
    view "news"
end



