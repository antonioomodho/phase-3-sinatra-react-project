class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
#   # Add your routes here
#   get "/" do
#     { message: "Good luck with your project!" }.to_json
  end
#   get "/users" do
#     users = Users.all
#     users.to_json
#   end
#   get "/pets" do
#     pets = Pets.all.order(name: :breed).
#     pets.to_json
# end

#  end
# get "/users" do
#   users = users.all
#   users.to_json
# end

# get "/pets" do
#   pets = pets.all
#   pets.to_json
# end

#----------------------------------
class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    "WELCOME TO PETSTORE"
  end

  #view all the pets available
  get "/pets" do
    pets = Pet.all
    pets.to_json
  end

  #search for a specific pet using its id
  get '/pets/:id' do |id|
    pet = Pet.find(id)
    if pet
      pet.to_json
    else
      halt 404, { error: "Pet with id #{id} not found" }.to_json
    end
  end
  

  #view all the users
  get "/users" do
    users = User.all
    users.to_json
  end  

  #add new pets
  post '/pets/addpet' do
    begin
      request.body.rewind
      data = JSON.parse(request.body.read)
      pet = Pet.new(name: data['name'], breed: data['breed'], user_id: data['pet_id'])
    
      if pet.save
        { message: "Pet with id #{pet.id} created successfully", data: pet }.to_json
      else
        halt 500, { error: "Failed to create pet" }.to_json
      end
    rescue => e
      halt 500, { error: e.message }.to_json
    end
  end
  
  #view all new pets added
  get "/pets/newpets" do
    pets = Pet.all
    pets.to_json     

  end


  #search for pet through name 
  get '/pets/findpet/:name' do |name|
    pet = Pet.find_by(name: name)
    if pet
      pet.to_json
    else
      halt 404, { error: "Pet with name #{name} not found" }.to_json
    end
  end


  #update age of new pet added 
  patch '/pets/:id/update_age' do |id|
    pet = Pet.find { |p| p[:id] == id.to_i }
  
    if pet
      request.body.rewind
      data = JSON.parse(request.body.read)
      pet.update(age: data['age']) # This line updates the age in the database
      { message: "Pet with id #{id} age updated successfully", data: pet }.to_json
    else
      halt 404, { error: "Pet with id #{id} not found" }.to_json
    end
  end
  
  #delete new pets
  delete '/pets/deletepets/:id' do |id|
    pet = Pet.find_by(id: id)
  
    if pet
      pet.destroy
      { message: "Pet with id #{id} deleted successfully" }.to_json
    else
      halt 404, { error: "Pet with id #{id} not found" }.to_json
    end
  end

  #remove details of new pets added
  delete '/pets/' do
    pet = Pet.find_by(age: params[:age])
    pet.update(age: nil)
  end


  #not able to update pets not added

end