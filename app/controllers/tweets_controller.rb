class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in?
            @user = current_user
            @tweets = Tweet.all
        else
            redirect to "/login"
        end
        erb :'/tweets/tweets'
    end

    get '/tweets/new' do 
        if logged_in?
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

   post '/tweets' do
    
    if !params[:content].blank?
        @tweet = Tweet.new(content: params[:content])
        @tweet.user = current_user
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
    else
        redirect to "/tweets/new"
    end
   end

    get '/tweets/:id' do 
        
        @tweet = Tweet.find(params[:id])
            if logged_in? 
                erb :'tweets/show_tweet'
            else 
                redirect to "/login"
            end
    end

    get '/tweets/:id/edit' do 
        if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/edit'
        else
           redirect to '/login' 
        end
    end

    patch '/tweets/:id' do 
        if logged_in?
            Tweet.find(params[:id]).tap do |tweet|
              tweet.update(content: params[:content]) if current_user == tweet.user
              redirect "/tweets/#{tweet.id}/edit"
            end
          else
            redirect '/login'
          end
        
    end

    put '/tweets/:id' do 
        if logged_in?
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
          if logged_in? && @tweet.user == current_user
            @tweet.destroy
             redirect '/tweets'
          else
            redirect to '/login'
          end 
      end 
    


end
