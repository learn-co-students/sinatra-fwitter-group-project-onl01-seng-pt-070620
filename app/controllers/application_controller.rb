require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
      set :public_folder, 'public'
      set :views, 'app/views'
    end

    enable :sessions
    set :session_secret, "secret_tweets"
    set :views, Proc.new { File.join(root, "../views/") }

    get '/' do 
      erb :'/users/homepage'
    end 

    

    helpers do 

      def current_user(session)
        if session[:id] != nil
          User.find(session[:id])
        end
      end
  
      def logged_in?(session)
        if session[:id] != nil
          user_id = current_user(session).id
          session[:id] == user_id ? true : false
        end
      end

      def find_tweet(id)
        Tweet.find_by_id(id)
      end 

    end 

end
