require 'pry'
require './config/environment'

class ApplicationController < Sinatra::Base


  #include Helpers

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "fwitter_secret"

  end

  enable :method_override
  enable :sessions

  get '/' do
    erb :index
  end

  helpers do
    def current_user
        if session[:id] != nil 
        @user = User.find(session[:id])
      end
    end

    def logged_in?
      current_user ? true : false
    end
  end


end
