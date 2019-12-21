# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    auth = request.env['omniauth.auth']
    @user = User.find_for_github_oauth(auth, current_user)

    if @user.persisted?
      @user.set_avatar(auth)
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      session['devise.github_data'] = auth
      redirect_to new_user_registration_url
    end

    rescue ActiveRecord::RecordInvalid => e
      redirect_to root_path, alert: e.message
  end

  def failure
    redirect_to root_path
  end
end
