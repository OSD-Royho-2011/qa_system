class ApplicationController < ActionController::Base
  include AuthHelper
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t('messages.access_denied')
    redirect_to root_path
  end

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/page_404', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500
    respond_to do |format|
      format.html { render template: 'errors/page_500', status: 500 }
      format.all { render nothing: true, status: 500 }
    end
  end

  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url
      end
    end

  protected
    # Get model name from controller
    class << self
      def permission
        return name = self.name.gsub("Controller","").singularize.split("::").last.constantize.name rescue nil
      end
    end

    # Current ability
    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    # Load all permissions of current_user
    def load_permissions
      @current_permissions = current_user.role.permissions.collect{|p| [p.subject_class, p.action]}
    end
end
