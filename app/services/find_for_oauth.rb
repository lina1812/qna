class FindForOauth
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    if auth.info[:email]
      find_or_create_user_by_email(auth)
    else
      User.new
    end
  end

  private

  def find_or_create_user_by_email(auth)
    email = auth.info[:email]
    user = User.where(email: email).first
    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.new(email: email, password: password, password_confirmation: password)
      user.confirm
      user.create_authorization(auth)
    end

    user
  end
end
