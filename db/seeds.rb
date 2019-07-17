Beer.destroy_all
Brewery.destroy_all

require 'rest-client'
require 'json'
require_relative '../tokens.rb'
beer_thing = "https://sandbox-api.brewerydb.com/v2/beer/c4f2KE/breweries/?key=ece5c0b8d7abfb101080233d5e7fc600"
brewery_url = "#{BREWERY_URL}breweries/?key=#{API_KEY}"
breweries = JSON.parse(RestClient.get(brewery_url).body)["data"]
beer_url = "#{BREWERY_URL}beers/?key=#{API_KEY}"
beers = JSON.parse(RestClient.get(beer_url).body)["data"]


def make_beers
    beer_url = "#{BREWERY_URL}beers/?key=#{API_KEY}"
    beers = JSON.parse(RestClient.get(beer_url).body)["data"]
    beers.each do |beer|
        beer_url_id = "#{BREWERY_URL}beer/#{beer["id"]}/breweries/?key=#{API_KEY}"
        brewery_name = JSON.parse(RestClient.get(beer_url_id).body)["data"][0]["name"]
        brewery = Brewery.find_or_create_by(name: brewery_name)
        # binding.pry
        style = beer["style"] || {"description" => "no words... should have sent a poet"}
        description = style["description"] || "no words... should have sent a poet"
        Beer.create(name: beer["name"], blurb: description, brewery: brewery)
        end
    end


    def make_breweries
        brewery_url = "#{BREWERY_URL}breweries/?key=#{API_KEY}"
        breweries = JSON.parse(RestClient.get(brewery_url).body)["data"]
        breweries.each do |brewery|
            Brewery.create(name: brewery["name"], blurb: brewery["description"])
        end
    end

make_breweries
make_beers