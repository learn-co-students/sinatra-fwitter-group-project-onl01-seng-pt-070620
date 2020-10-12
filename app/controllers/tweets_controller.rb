class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in?
            @user = current_user
        else
            redirect to "/login"
        end
        erb :'/tweets/tweets'
    end








end
