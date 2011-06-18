class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :process_oauth_callback

  def facebook; end
  def github; end
  def twitter; end
  def vkontakte; end

  protected
  def process_oauth_callback
    provider = params[:action]

    @user = User.find_by_oauth(env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider
      sign_in_and_redirect @user, :event => :authentication
    else
      # Закомментировано, потому что вызывает переполнение cookies
      # ActionDispatch::Cookies::CookieOverflow
      #session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
