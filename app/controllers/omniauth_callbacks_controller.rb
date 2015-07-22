class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_omniauth(user_params)
    if user.persisted?
      flash[:notice] = "Welcome, #{:name}!"
      sign_in_and_redirect user
    else
      flash[:notice] = "nope"
      session['devise.user_attributes'] = user.attributes
      redirect_to new_user_session_path
    end
  end

  private

  def user_params
    p = ActionController::Parameters.new(request.env["omniauth.auth"])
    p.permit(:provider, :uid)
  end

  # raise request.env['omniauth.auth'].inspect
end