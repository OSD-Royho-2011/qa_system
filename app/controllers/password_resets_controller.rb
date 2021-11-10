class PasswordResetsController < ApplicationController
	before_action :get_user, only: [:edit, :update]
	before_action :valid_user, only: [:edit, :update]
	before_action :check_expiration, only: [:edit, :update]

	def new; end

	def create
		@user = User.find_by(email: params[:password_reset][:email].downcase)
		if @user
			@user.create_reset_digest
			@user.send_password_reset_email
			render :confirm_email, object: @user 
		else
			flash.now[:danger] = t('messages.email_not_found')
			render :new
		end
	end

	def edit; end

	def update
		if params[:user][:password].empty?
			@user.errors.add(:password, t('messages.can_be_empty'))
			render :edit
		elsif @user.update(user_params)
			log_in @user
			@user.update_attribute(:reset_digest, nil)
			flash[:primary] = t('messages.psw_has_reset')
			redirect_to @user
		else
			render :edit
		end
	end

	private

		def user_params
			params.require(:user).permit(:password, :password_confirmation)
		end

		def get_user
			@user = User.find_by(email: params[:email])
			return unless @user.nil?
			flash[:danger] = t('messages.user_not_exist')
			redirect_to login_url
		end

		# Confirms a valid user.
		def valid_user
			return if @user.blank?
			return if @user.activated?
			return if @user.authenticated?(:reset, params[:id])
			redirect_to root_url
		end

		# Checks expiration of reset token.
		def check_expiration
			return unless @user.password_reset_expired?
			flash[:danger] = t('messages.psw_reset_expired')
			redirect_to new_password_reset_url
		end
end
