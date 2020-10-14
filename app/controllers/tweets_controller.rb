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
        if logged_in?
            erb :"tweets/new"
        else
            redirect to "/login"
        end
    end

    post '/tweets' do
        @user = current_user

        if params[:content] == ""
            redirect to "/tweets/new"
        else
            @tweet = Tweet.create(user: @user, content: params[:content])
            redirect to "/tweets"
        end
    end
        
    get '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
    
        if logged_in?   
            @user = current_user
            erb :"tweets/show"
        else
            redirect to "/login"       
        end
    end

    patch '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find(params[:id])
            @tweet.update(content: params[:content]) if current_user == @tweet.user
             
            redirect "tweets/#{@tweet.id}/edit"
        else
            redirect "/login"
        end
    end


    get '/tweets/:id/edit' do
         
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :"tweets/edit"
        else
            redirect "/login"    
        end
    end

    delete '/tweets/:id' do

        if logged_in?
            binding.pry
        @tweet = Tweet.find(params[:id])
        if current_user == @tweet.user 
        @tweet.delete
        end
    
        redirect "/tweets"
        end
    end
end



