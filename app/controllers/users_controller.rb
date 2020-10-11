class UsersController < ApplicationController

    get '/' do  
        @user = current_user if is_logged_in?
        erb :index
    end 

    get '/signup' do
        if is_logged_in?
            redirect to '/tweets'
        else 
            erb :'users/signup'
        end 
    end 

    post '/signup' do
        user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
        if user.save && user.username != "" && user.email != "" && user.password != ""
          session[:user_id] = user.id
          redirect to "/tweets"
        else
          redirect to '/signup'
        end
    end

    get '/login' do 
        if is_logged_in?
            redirect to '/tweets'
        else 
        erb :'users/login' 
        end
    end 

    post "/login" do
        user = User.find_by(:username => params[:username])
     
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
         # binding.pry
          redirect to "/tweets"
        end 
    end 

    get '/logout' do
        session.clear
        redirect to '/login'
    end
end 