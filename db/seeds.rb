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
    beers = JSON.parse(RestClient.get(beer_url).body)["data"].compact
    beers.each do |beer|
        beer_brewery = "#{BREWERY_URL}beer/#{beer["id"]}/breweries/?key=#{API_KEY}"
        this_beer_url = "#{BREWERY_URL}beer/#{beer["id"]}/?key=#{API_KEY}"
        this_beer = JSON.parse(RestClient.get(this_beer_url).body)["data"]
        brewery_name = JSON.parse(RestClient.get(beer_brewery).body)["data"][0]["name"]
        brewery = Brewery.find_or_create_by(name: brewery_name)
        this_beer_style = this_beer["style"] || {"name"=>"Too new to know", "shortName"=>"Too new to know", "id"=>27} 
        this_beer_labels = this_beer["labels"] || {"medium"=>"https://brewerydb-images.s3.amazonaws.com/beer/aG4Ie2/upload_yX4wkY-medium.png"}
        beer_style = this_beer["name"] || "New Style"
        short_type = this_beer["shortName"] || "New Style"
        style_id = this_beer["id"] || 27
        icon_url = this_beer_labels["medium"] || "https://brewerydb-images.s3.amazonaws.com/beer/aG4Ie2/upload_yX4wkY-medium.png"
        style = beer["style"] || {"description" => "no words... should have sent a poet"}
        description = style["description"] || "no words... should have sent a poet"
        Beer.create(name: beer["name"], 
            blurb: description, 
            brewery: brewery, 
            beer_style: beer_style, 
            short_type: short_type,
            style_id: style_id,
            icon: icon_url
            )
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