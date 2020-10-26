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
    if is_logged_in?
      # @tweet = Tweet.find(params[:id])
      # # @user = current_user
      erb :'tweets/new'
    else
      redirect '/login'
    end 
  end 
  
  post '/tweets' do 
    if is_logged_in?
      # @tweet = Tweet.new(:content => params[:content])
      Tweet.new(content: params[:content]).tap do |tweet|
        tweet.user = current_user 
        if params[:content].blank?
          redirect '/tweets/new'
        else
          tweet.save
        redirect "/tweets/#{tweet.id}"
        end
      end
    end 
  end

  get '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if is_logged_in?
        erb :'tweets/show'
    else
    redirect to '/login'
    end 
  end 

  get '/tweets/:id/edit' do 
    
    if is_logged_in? #&& @tweet.user = current_user
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  put '/tweets/:id' do 
    if is_logged_in?
      Tweet.find(params[:id]).tap do |tweet|
        tweet.update(content: params[:content]) if current_user == tweet.user
        redirect "/tweets/#{tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end 

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
      if is_logged_in? && @tweet.user == current_user
        @tweet.destroy
         redirect '/tweets'
      else
        redirect to '/login'
      end 
  end 
end
