module Users
  class GetEmailsController < ActionController::Base
    def show
    end
    
    def create
      auth = session[:auth]
      auth['info']['email'] = params[:email]
      user = User.find_for_oauth(OmniAuth::AuthHash.new(auth))
      
      if user&.persisted?
        user.confirmed_at = nil
        user.send_confirmation_instructions
        session[:auth] = nil
        redirect_to root_path, alert: 'Need email confirm'
      else
        redirect_to users_get_email_path, alert: 'Something went wrong'
      end
    end
  end
end
