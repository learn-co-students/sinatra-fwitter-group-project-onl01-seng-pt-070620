class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            @user = current_user
            erb :"tweets/index"
        else
            redirect "/login" 
        end
    end

    get '/tweets/new' do
        erb :new
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:user_id])
            erb :"users/show"
        else
            redirect "/login"    
            
        end
    end

    get '/tweets/new' do
        if logged_in?
        erb :"tweets/new"
        end
    end

    post '/tweets/new' do
      

    end


    




end
