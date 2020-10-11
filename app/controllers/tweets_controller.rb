class TweetsController < ApplicationController

    get '/tweets' do 
        if is_logged_in?
            @user = current_user
            @tweets = Tweet.all 
            erb :'tweets/tweets'
        else 
            redirect '/login'
        end 
    end 

    get '/tweets/new' do 
        @tweet = Tweet.find_by_id(params[:id])
        if is_logged_in?
            @user = current_user
        erb :'tweets/new'
      else
          redirect '/login'
      end 
    end 

    post '/tweets' do 
        if is_logged_in?
        @tweet = Tweet.create(:content => params[:content], :user_id => params[:user_id])
        redirect to "/tweets/#{@tweet.id}"
        end 
    end 

    get '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        if is_logged_in?
            erb :'tweets/show'
        else
        redirect to '/login'
        end 
    end 

    get '/tweets/:id/edit' do 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/edit'
    end 

    patch '/tweets/:id' do 
        id = params[:id]
        @tweet = Tweet.find_by(id: id)
        attributes = params[:tweet]
        @tweet.update(attributes)
        redirect to "/tweets/#{@tweet.id}"
    end 

      delete '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if is_logged_in?
            @user = current_user
        Tweet.destroy(id)
        redirect to '/login'
        end 
    end 
end

