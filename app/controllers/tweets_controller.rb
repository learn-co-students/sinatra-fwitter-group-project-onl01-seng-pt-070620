class TweetsController < ApplicationController

  get '/tweets' do
    redirect '/login' if logged_in? == false
    @user = current_user
    @tweets = Tweet.all
    erb :'/tweets/home'
  end

  post '/tweets' do
    if !params[:content].empty?
    Tweet.create(content: params[:content]).tap do |tweet|
      tweet.user = current_user
      tweet.save
      redirect "/tweets/#{tweet.id}"
    end
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      @tweet = Tweet.find(params[:id])
      if @tweet.user == @user
      erb :'/tweets/show'
      end
    end
  end

  patch '/tweets/:id' do
    Tweet.find(params[:id]).tap do |tweet|
      tweet.update(content: params[:content]) if current_user == tweet.user
      redirect "/tweets/#{tweet.id}"
    end
  end

  get '/tweets/:id/edit' do
    @user = current_user
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
  end

end
