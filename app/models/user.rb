class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
<<<<<<< HEAD
  
=======

>>>>>>> 18c0b426ab2fec0fae532bc5095ea1ac27a8c350
  def slug
    self.username.strip.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    username = slug.split('-').join(' ')
    User.find_by(:username => username)
  end
<<<<<<< HEAD
=======

>>>>>>> 18c0b426ab2fec0fae532bc5095ea1ac27a8c350
end
