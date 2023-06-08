class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

 end
# get "/users" do
#   users = users.all
#   users.to_json
# end

# get "/pets" do
#   pets = pets.all
#   pets.to_json
# end