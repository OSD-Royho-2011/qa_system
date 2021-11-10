class UsersController < ApplicationController
	before_action :logged_in_user, only: [:show, :edit, :destroy, :profile, :setting]
	
	def show; end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
			flash[:secondary] = t('messages.check_email')
			redirect_to login_url
		else
			render :new
		end
	end

	def switch_mode
		if !current_user.update_cognito
			flash[:danger] = t('messages.post_failed')
			redirect_to root_path
		end	
	end

	def destroy; end
	
	def profile; end

	def setting; end

	def edit; end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end
