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
       # @tweet = Tweet.find_by_id(params[:id])
        if is_logged_in?
            @user = current_user
        erb :'tweets/new'
      else
          redirect '/login'
      end 
    end 

    post '/tweets' do 
        if is_logged_in?
            #binding.pry 
            if !params[:content].empty? 
                
                 @tweet = Tweet.create(:content => params[:content], :user_id => current_user.id)
                    redirect to "/tweets/#{@tweet.id}"
            else
                    redirect to '/tweets/new'
            end 
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
        if is_logged_in?
            @user = current_user
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/edit'
        else
           redirect to '/login' 
        end
    end 

    patch '/tweets/:id' do 
        if is_logged_in?
            id = params[:id]
            @tweet = Tweet.find_by(id: id)
            if !params[:content].empty?
                @tweet.update(:content => params[:content])
                redirect to "/tweets/#{@tweet.id}"
            else
            redirect to "/tweets/#{id}/edit"
            end
        else 
            redirect to '/login'
        end  
    end 

delete "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])

    if is_logged_in? && @tweet.user == current_user
        @tweet.delete
        redirect to '/tweets'
        else
        redirect to "/login"
      end
  
    end
end 