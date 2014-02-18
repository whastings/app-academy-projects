require 'rest-client'
require 'addressable/uri'
require 'json'
require 'nokogiri'

api_key = nil
begin
  api_key = File.read('.api_key').chomp
rescue
  puts "Unable to read '.api_key'. Please provide a valid Google API key."
  exit
end

puts "Please enter a starting address:"
current_location = gets.chomp

geocode_uri = Addressable::URI.new(
  :scheme => "https",
  :host => "maps.googleapis.com",
  :path => "/maps/api/geocode/json",
  :query_values => {
    :address => current_location,
    :sensor => false,
    :key => api_key
  }
)

location_info = JSON.parse(RestClient.get(geocode_uri.to_s))
location_info = location_info["results"].first["geometry"]["location"]

search_uri = Addressable::URI.new(
  :scheme => "https",
  :host => "maps.googleapis.com",
  :path => "maps/api/place/nearbysearch/json",
  :query_values => {
    :key => api_key,
    :location => "#{location_info['lat']},#{location_info['lng']}",
    :sensor => false,
    :radius => 1000,
    :keyword => 'icecream'
  }
)

results = JSON.parse(RestClient.get(search_uri.to_s))["results"]
puts "Here are icecream locations near you."
puts "Please enter the number of which location to get directions to:"
results.each_with_index do |result, number|
  puts "#{number}: #{result["name"]}"
  puts result["vicinity"]
  puts "Rating: #{result['rating']}"
  puts
end

location_choice = Integer(gets.chomp)
chosen_location = results[location_choice]
destination_location = chosen_location["geometry"]['location']

directions_uri = Addressable::URI.new(
  :scheme => "https",
  :host => "maps.googleapis.com",
  :path => "/maps/api/directions/json",
  :query_values => {
    :key => api_key,
    :origin => "#{location_info['lat']},#{location_info['lng']}",
    :destination => "#{destination_location['lat']},#{destination_location['lng']}",
    :sensor => false,
    :mode => "walking"
  }
)

direction_data = JSON.parse(RestClient.get(directions_uri.to_s))
direction_steps = direction_data["routes"].first["legs"].first["steps"]

direction_steps.each_with_index do |step, index|
  step_text = Nokogiri::HTML(step["html_instructions"]).text
  puts "#{index}: #{step_text}"
  puts
end

