class AdminController < ApplicationController
  before_action :logged_in_user
  before_action :is_super_admin, only: [:management, :edit_user_role]
  before_action :is_admin_or_manager, except: [:management, :edit_user_role]
  before_action :load_user, only: [:edit_user_role]

  def index
    @questions = Question.all
  end

  def management
    @users = User.where_not_admin
    @roles = Role.where_not_admin
  end

  def edit_user_role
    @user.update_attribute(:role_id, params[:user][:role_id])
    flash[:success] = t('messages.update_role_succes')
    redirect_to user_management_path
  end

  private
    def load_user
      @user = User.find_by(id: params[:id])
      return if @user.present?
      flash[:danger] = t('messages.user_not_exist')
      redirect_to user_management_path
    end

    def is_super_admin
      redirect_to root_path unless current_user.super_admin?
      flash[:danger] = t('messages.no_permission') unless current_user.super_admin?
    end

    def is_admin_or_manager
      return if current_user.super_admin? || current_user.manager?
      flash[:danger] = t('messages.no_permission')
      redirect_to root_path
    end
end
