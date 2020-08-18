class UsersController < ApplicationController 
    get '/signup' do 
      erb :'users/signup' #now create 'signup.erb' under views/users
    end 

    post '/signup' do
      # binding.pry---couldn't get pry to open
      if params[:username].empty? || params[:email].empty?
        @error = "All fields must be completed"
        erb :'users/signup'
      else 
        user = User.create(params)
        session[:user_id] = user.id
        redirect '/kid/register_kids'  
      end 
    end

    get '/login' do 
        erb :'/users/login'
    end

    post '/login' do     #need to authenticate pw
      @user = User.find_by(email: params[:email])

      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/behavior_logs'
       else
        flash[:error] = "Invalid credentials. Try again!"
        redirect to '/login'
      end
    end

    get '/logout' do
      session.clear
      redirect '/'
  end
end 