class TweetsController < ApplicationController
    post '/tweets' do
        if !params[:content].empty?
            @tweet = Tweet.create(content: params[:content], user: current_user)
            redirect '/tweets'
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets' do
        if logged_in?
          @user = current_user
          @tweets = Tweet.all
          erb :'/tweets/index'
        else
          redirect '/login'
        end
    end
    
    get '/tweets/new' do
        if logged_in?
          @user = current_user
          erb :'/tweets/new'
        else
          redirect '/login'
        end
    end
    
    get '/tweets/:id' do
        if logged_in?
          @user = current_user
          @tweet = Tweet.find(params[:id])
          erb :'/tweets/show'
        else
          redirect to '/login'
        end
    end
    
    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && @tweet.user == current_user
          erb :'/tweets/edit'
        else
          redirect '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if logged_in? && @tweet.user == current_user
            @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        if logged_in? && @tweet.user == current_user
            @tweet.delete
            redirect '/tweets'
        else
            redirect '/login'
        end
    end
end