class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'/users/new'
  end

  get '/users/:id' do
    @user = current_user
    erb :'/users/show'
  end

  get '/logout' do
    redirect :index if !logged_in?
    session.clear
    redirect '/login'
    erb :'/users/logout'
  end

  post '/logout' do
    session.clear
    redirect '/login'
  end

  get '/login' do
    redirect '/tweets' if logged_in?
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if !@user.nil? && !!@user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect '/login'
      end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'
      else
    @user = User.create(params) if !!User.find_by(email: params[:email]).nil?
    session[:user_id] = @user.id
    redirect '/tweets'
    end
  end



end
