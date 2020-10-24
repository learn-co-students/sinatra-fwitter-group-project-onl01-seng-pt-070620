class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if !params[:content].empty?
            tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
            redirect "/tweets/#{tweet.id}"
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :"/tweets/show"
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :"/tweets/edit"
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        if params[:content] == ""
            redirect "/tweets/#{params[:id]}/edit"
        else
            tweet = Tweet.find(params[:id])
            tweet.content = params[:content]
            tweet.save
            redirect "/tweets/#{params[:id]}"
        end
    end

    delete '/tweets/:id' do
        if logged_in?
            if params[:id] == session[:user_id].to_s
                tweet = Tweet.find(params[:id])
                tweet.delete
            end
            redirect "/tweets"
        else
            redirect '/login'
        end
    end

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if !params[:content].empty?
            tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
            redirect "/tweets/#{tweet.id}"
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :"/tweets/show"
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :"/tweets/edit"
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        if params[:content] == ""
            redirect "/tweets/#{params[:id]}/edit"
        else
            tweet = Tweet.find(params[:id])
            tweet.content = params[:content]
            tweet.save
            redirect "/tweets/#{params[:id]}"
        end
    end

    delete '/tweets/:id' do
        if logged_in?
            if params[:id] == session[:user_id].to_s
                tweet = Tweet.find(params[:id])
                tweet.delete
            end
            redirect "/tweets"
        else
            redirect '/login'
        end
    end

end
