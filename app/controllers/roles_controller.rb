class RolesController < ApplicationController
  before_action :logged_in_user
  load_and_authorize_resource
  before_action :load_permissions
  before_action :is_super_admin
  before_action :build_role, only: [:index]
  before_action :load_role, except: [:index, :create, :load_permission_actions]

  def index
    @roles = Role.where_not_admin
  end

  def create 
    @role = Role.new(role_params)
    flash[:success] = t('messages.add_role_success') if @role.save
    redirect_to roles_path
  end

  def show
    @permissions = @role.permissions.group_by(&:subject_class)
    @role_permissions = Permission.where_not_admin_permission.group_by(&:subject_class)
  end

  def destroy
    flash[:success] = t('messages.delete_role_success', role: @role.name) if @role.destroy
    flash[:success] = t('messages.cannot_delete_role', role: @role.name) if !@role.destroy
    redirect_to roles_path
  end

  def create_permission_role
    @role.set_permissions(params[:permissions]) if params[:permissions]
    redirect_to @role if @role.save
  end

  def delete_role_permission
    @role_permission = PermissionsRole.find_by(permission_id: params[:permission_id])
    flash[:success] = t('messages.delete_permission_success') if @role_permission.destroy
    redirect_to @role
  end

  def load_permission_actions
    @actions = Permission.where(subject_class: params[:subject_class])
    if request.xhr?
      respond_to do |format|
        format.json {
          render json: {actions: @actions}
        }
      end
    end
  end

  private
    def role_params
      params.require(:role).permit(:name, :description)
    end

    def build_role
      @role = Role.new
    end

    def load_role
      @role = Role.find(params[:id])
      return if @role.present?
      flash[:danger] = t('messages.role_not_exist')
      redirect_to roles_path
    end

    def is_super_admin
      redirect_to root_path and return unless current_user.super_admin?
    end

end
