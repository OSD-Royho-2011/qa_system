class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:activation_token])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:primary] = t('messages.activated')
      redirect_to user
    else
      flash[:danger] = t('messages.invalid_activate_link')
      redirect_back(fallback_location: login_path)
    end
  end
end
