class OauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    callback(kind: 'Github')
  end

  def facebook
    callback(kind: 'Facebook')
  end

  def google_oauth2
    callback(kind: 'Google')
  end

  private

  def callback(kind)
    user = User.find_for_oauth(request.env['omniauth.auth'])
    if user&.persisted? && user&.confirmed?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    elsif user && user.email.blank?
      session[:auth] = request.env['omniauth.auth']
      redirect_to users_get_email_path, alert: 'Something went wrong'
    else
      redirect_to root_path, alert: 'Something went wrong'
    end
  end
end
