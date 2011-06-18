require 'open-uri'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :full_name, :nick, :location, 
    :avatar, :confirmed_at, :provider, :uid

  validates_presence_of :provider
  validates_presence_of :uid

  has_and_belongs_to_many :roles
  has_attached_file :avatar, :styles => { :large => '200x200>', :thumb => '50x50#' }

  def role_symbols
    ((roles || []).map {|r| r.name.to_sym } + [ :regular ]).uniq
  end

  def self.find_by_oauth(oauth, signed_in_resource = nil)
    data = oauth['extra']['user_hash']

    if data["email"]
      user = User.find_by_email(data["email"])
      if user
        # TODO: 
        # 1. привязать несколько провайдеров к одному пользователю
        # 2. проверить есть ли такой провайдер у найденного пользователя
        # 3. если нет, то создать ещё одного провайдера
        return user
      end
    end

    user = User.find_by_uid_and_provider(oauth['uid'], oauth['provider'])
    return user if user

    user = User.new(:uid => oauth['uid'],
      :provider => oauth['provider'],
      :password => Devise.friendly_token[0,20], 
      :confirmed_at => Time.now,
      :full_name => data["name"],
      :location => data["location"]
    )

    user.email = data["email"] if data["email"]

    case oauth['provider']
      when 'facebook'
        user.nick = data["name"]
        avatar_url = oauth["user_info"]["image"].sub(/square/, 'large')
        user.avatar = avatar_io(avatar_url)
      when 'twitter'
        user.nick = data["screen_name"]
        #:? =>  data["url"]
        #:? => data["description"]
        user.avatar = avatar_io(data["profile_image_url"])
      when 'github'
        user.nick = data["login"]
        user.avatar = avatar_io("http://gravatar.com/avatar/#{data['gravatar_id']}?s=512") if data['gravatar_id']
    end
    user.save
    user
  end 

  def self.avatar_io(avatar_url)
    io = open(URI.parse(avatar_url))
    def io.original_filename; base_uri.path.split('/').last; end
    io
  end

  def using_oauth?
    !!self.provider
  end

  def valid?(options = nil)
    super(options)
    if using_oauth?
      self.errors.delete :email
      self.errors.delete :password
    else
      self.errors.delete :provider
      self.errors.delete :uid
    end

    return self.errors.count == 0
  end
end
