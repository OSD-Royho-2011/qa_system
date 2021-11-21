class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  load_and_authorize_resource :except => [:new, :create]
  before_action :load_permissions, except: [:new, :create]
  before_action :set_change_password_flag, only: [:change_password]
  before_action :load_user, only: [:show]

  def show
    @questions = @user.questions
    @questions = @user.questions.approved if @user.id != current_user.id
    if @user.id == current_user.id
      @private_questions = Question.where(user_id: nil)
      @private_questions.each do |question|
        @questions = @questions.concat(question) if decrypt(question.private_token).to_i == @user.id
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = Role.find_by(name: "Member")
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

  def edit; end

  def update_basic_info
    flash[:success] = t('messages.update_info_success') if current_user.update(basic_info_params)
    render :edit
  end

  def change_password
    if current_user&.authenticate(params[:old_password])
      if params[:user][:password].empty?
        current_user.errors.add(:password, t('messages.can_be_empty'))
        render :edit
      elsif current_user.update(change_password_params)
        current_user.update_attribute(:reset_digest, nil)
        flash[:primary] = t('messages.psw_has_reset')
        render :edit
      end
    else
      current_user.errors.add(:old_password, t('messages.invalid_old_password'))
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def change_password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def basic_info_params
      params.require(:user).permit(:name, :email, :image)
    end

    def set_change_password_flag
      @change_psw_flag = true
    end

    def load_user
      @user = current_user if params[:id].nil?
      @user = User.find_by(id: params[:id]) if params[:id].present?
      return if @user.present?
      flash[:danger] = t('messages.user_not_exist')
      redirect_to root_path
    end

end
