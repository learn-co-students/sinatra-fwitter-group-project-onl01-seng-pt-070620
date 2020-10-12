class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in?(session)
            @user = current_user(session)
        else
            redirect to "/login"

        end
        erb :'/tweets/tweets'
    end






end
