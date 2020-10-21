class Helpers < ActiveRecord::Base
  
  def current_user
    @user = User.find_by(id: session[:user_id])
  end
   
#boolean to check login

  def is_logged_in?
    !!current_user
  end
  
  
  
  
  
  
end