require 'open-uri'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :full_name, :nick, :location, :email, :password, :password_confirmation, :remember_me, :avatar, :confirmed_at

  has_attached_file :avatar, :styles => { :large => '200x200>', :thumb => '50x50#' }

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password. 

      avatar_url = access_token["user_info"]["image"].sub(/square/, 'large')

      io = open(URI.parse(avatar_url))
      def io.original_filename; base_uri.path.split('/').last; end

      User.create!(:email => data["email"], 
        :password => Devise.friendly_token[0,20], 
        :confirmed_at => Time.now,
        :full_name => data["name"],
        :nick => data["name"],
        #:avatar => (open(URI.parse(avatar_url)) rescue nil)
        :avatar => io
      ) 
    end
  end 
end
