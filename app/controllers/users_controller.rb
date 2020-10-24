class UsersController < ApplicationController
    
    get '/signup' do 
        erb :'users/signup'
    end
    
    post '/signup' do 
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect '/signup'
        else
            user = User.new
            user.username = params[:username]
            user.email = params[:email]
            user.password = params[:password]
            user.save
            session["user_id"] = user.id
            redirect "/tweets"
        end
    end 
    
    get '/login' do
        erb :'users/login'
    end

<<<<<<< HEAD
    post '/login' do 
        user = User.find_by(username: params[:username])
=======
    get '/signup' do
        erb :'/users/signup'
    end

    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect '/signup'
        else
            user = User.new
            user.username = params[:username]
            user.email = params[:email]
            user.password = params[:password]
            user.save
            session["user_id"] = user.id
            redirect "/tweets"
        end
    end

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
>>>>>>> 18c0b426ab2fec0fae532bc5095ea1ac27a8c350
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/failure"
        end
<<<<<<< HEAD
    end 
=======
    end

    get "/failure" do
        erb :"/users/failure"
    end
>>>>>>> 18c0b426ab2fec0fae532bc5095ea1ac27a8c350

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end
<<<<<<< HEAD
    
    get "/failure" do
        erb :"/users/failure"
    end
=======
>>>>>>> 18c0b426ab2fec0fae532bc5095ea1ac27a8c350

    get "/users/:slug" do
        # @tweets = Tweet.find_by(:user_id => session["user_id"])
        tweets = Tweet.find_by_slug(params[:slug])
        erb :'/users/show'
    end

end
