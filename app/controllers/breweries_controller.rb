class BreweriesController < Sinatra::Base
    set :views, 'app/views/breweries'
    set :method_override, true


    get '/breweries' do
        @breweries = Brewery.all
        erb :index
    end
    
    get '/breweries/new' do
        erb :new
    end

    get '/breweries/:id' do 
        id = params[:id]
        @brewery = Brewery.find(id)
        erb :show
    end

    get '/breweries/:id/edit' do
        @brewery = Brewery.find(params[:id])
        erb :edit
    end

    put '/breweries/:id' do
        @brewery = Brewery.find(params[:id])
        @brewery.update(name: params[:name], location: params[:location], blurb: params[:blurb])
        redirect "/breweries/#{@brewery.id}"
    end

    post '/breweries' do
        @brewery = Brewery.find_or_create_by(name: params[:name], location: params[:location], blurb: params[:blurb])
        redirect "/breweries/#{@brewery.id}"
    end
end