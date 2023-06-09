class PetController < Sinatra::Base
    set :default_content_type, 'application/json'
    get "/pets" do
        pets = Pet.all
        pets.to_json
    end
    post '/pets/addpet' do
        begin
            data = JSON.parse(request.body.read)
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
