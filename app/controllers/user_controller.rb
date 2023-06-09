class UserController < Sinatra::Base
    set :default_content_type, 'application/json'

    get "/users" do
          users = User.all
          users.to_json
        end
        post '/auth/register' do
            begin
                data = JSON.parse(request.body.read)
                users = User.create(data)
                users.to_json
            rescue => e
                error_response(404, e)
            end
        end
    
        post '/auth/login' do
            request.body.rewind
            request_payload = JSON.parse(request.body.read)
            email = request_payload['email']
            # puts "Email: #{email}" 
            password = request_payload['password'].to_i
            # puts "Password: #{password}
            user = User.find{ |u| u[:email] == email && u[:password] == password}
            if user
                {message: "Login success"}.to_json
            else
                {message: "Invalid email or password"}.to_json
            end
        end
    
    #     post '/users/:id/pets' do
    #         user = User.find(params[:id])
    #         pet = User.pets.new(params[:pet])
    #         if Pet.save
    #             redirect "/users/#{user.id}"
    #         else
    #             "There was an error saving your pet."
    #         end
    #     end
    end