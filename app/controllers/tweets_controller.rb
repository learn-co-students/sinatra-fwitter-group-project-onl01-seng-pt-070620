class TweetsController < ApplicationController

    get '/tweets' do 
        if is_logged_in?
            @user = current_user
            @tweets = Tweet.all 
            erb :'/tweets/tweets'
        else 
            redirect '/login'
        end 
    end 

    get '/tweets/new' do 
        if is_logged_in?
            @user = current_user
        erb :'/tweets/new'
      else
          redirect '/login'
      end 
    end 

    post '/tweets' do 
        @tweet = Tweet.create(:content => params[:content], :user_id => params[:user_id])
        redirect to "/tweets/#{@tweet.id}"
    end 

    get '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show'
    end 

    get '/tweets/:id/edit' do 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/edit'
    end 

    patch '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.user_id = params[:user_id]
        @tweet.content = params[:content]
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      end

      delete '/tweets/:id' do
        id = params[:id]
        Tweet.destroy(id)
        redirect to '/tweets'
    end 
end

