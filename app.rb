require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"
require "json"

get("/") do
  @all_curr_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("X_KEY")}"

  @curr_data = HTTP.get(@all_curr_url).to_s
  @curr_data_parsed = JSON.parse(@curr_data)
  @curr_results = []
  @curr_results = @curr_data_parsed.fetch("currencies").keys
  
  erb(:home)
end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  @all_curr_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("X_KEY")}"

  @curr_data = HTTP.get(@all_curr_url).to_s
  @curr_data_parsed = JSON.parse(@curr_data)
  @curr_results = []
  @curr_results = @curr_data_parsed.fetch("currencies").keys

  erb(:from_curr)
end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency").to_s
  @destination_currency = params.fetch("to_currency").to_s

  @all_curr_url = "https://api.exchangerate.host/convert?from=#{@original_currency}&to=#{@destination_currency}&amount=1&access_key=#{ENV.fetch("X_KEY")}"

  @curr_data = HTTP.get(@all_curr_url).to_s
  @curr_data_parsed = JSON.parse(@curr_data)
  @curr_results = @curr_data_parsed.fetch("result").to_f

  erb(:to_curr)
end
