class UserController < Sinatra::Base
    set :default_content_type, 'application/json'
    get "/user" do
        users = User.all
        users.to_json
    end
    post '/create' do
        begin
            data = JSON.parse(request.body.read)
            data["originally_fetched"] = false
            pets = Pet.create(data)
            pets.to_json
        rescue => e
            {
                error: e.message
            }.to_json
        end
    end

    get '/search' do
        query = params[:query]
        matching_pets = Pet.select{ |pet| pet[:name].include?(query) || pet[:breed].to_s.include?(query)}
        matching_pets.to_json
    end

    delete '/pets/destroy/:id' do
        begin
            pet = Pet.find(params[:id])
            pet.destroy
        rescue => e
            [404, {
                error: e.message
            }.to_json]
        end
    end

    put '/pets/update/:id' do
        data = JSON.parse(request.body.read)
        begin
            pets = Pet.find(params[:id])
            pets.update(data)
            { message: "update successfully" }.to_json
        rescue => e
            [404, {
                error: e.message
            }.to_json]
        end
    end
end