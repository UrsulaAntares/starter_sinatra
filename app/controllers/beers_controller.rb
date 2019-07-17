class BeersController < Sinatra::Base
    set :views, 'app/views/beers'
    set :method_override, true

    get '/beers' do 
        @beers = Beer.all
        erb :index
    end
    
        get '/beers/new' do
            erb :new
        end

    get '/beers/:id' do 
        id = params[:id]
        @beer = Beer.find(id)
        erb :show
    end

    get '/beers/:id/edit' do
        @beer = Beer.find(params[:id])
        erb :edit
    end 

    patch '/beers/:id' do
        @beer = Beer.find(params[:id])
        @beer.update(name: params[:name], blurb: params[:blurb])
        redirect "/beers/#{@beer.id}"
    end

    post '/beers' do
        brewery = Brewery.find(params[:brewery_id])
        @beer = Beer.find_or_create_by(name: params[:name], blurb: params[:blurb], brewery: brewery)
        redirect "/beers/#{@beer.id}"
    end
end