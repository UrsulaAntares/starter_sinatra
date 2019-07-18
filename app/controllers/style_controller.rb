class StylesController < Sinatra::Base
    set :views, 'app/views/styles'
    set :method_override, true

    get '/styles' do 
        @styles = []
        erb :index
    end

    get '/styles/:id' do
        erb :show
    end

end