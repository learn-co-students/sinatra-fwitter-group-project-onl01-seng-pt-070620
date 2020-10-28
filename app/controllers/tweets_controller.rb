class TweetsController < ApplicationController


    get '/tweets' do
        if logged_in?(session)
            @user = current_user(session)
            @tweets = Tweet.all
            @users = User.all
            erb :'/tweets/index'
        else
            redirect '/login'
        end 
    end 

    get '/tweets/new' do 
        if logged_in?(session)
            erb :'/tweets/new'
        else
            redirect to "/login"
        end 
    end 

    post '/tweets' do
            @tweet = Tweet.new(params)
            if @tweet.content == ""
                redirect to "/tweets/new"
            elsif @tweet.save
                @user = current_user(session)
                @user.tweets << @tweet
                redirect to "/tweets"
             else
                redirect to "/signup"
            end
    end 

    get '/tweets/:id' do
        if logged_in?(session)
           
            @tweet = find_tweet(params[:id])
            erb :'tweets/show_tweet'
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id/edit' do 
        if logged_in?(session)
            @tweet = find_tweet(params[:id])
            erb :"/tweets/show_tweet"
        else
            redirect to "/login"
        end 
    end 

    patch '/tweets/:id' do 
        @tweet = find_tweet(params[:id])
        @user = current_user(session)
        
            if @tweet.user_id == @user.id
                if params["content"] != ""
                    @tweet.content = params["content"]
                    @tweet.save
                    redirect to "/tweets/#{@tweet.id}/edit"
                else
                    redirect to "/tweets/#{@tweet.id}/edit"
                end   
            else 
                redirect to "/tweets"
            end 
    end 

    delete '/tweets/:id' do
        if logged_in?(session)
            @tweet = find_tweet(params[:id])
            @user = current_user(session)
            if @tweet.user_id == @user.id
                @tweet.delete
                redirect to '/tweets'
            else
                redirect to "/tweets"
            end 
        end 
    end 

end
