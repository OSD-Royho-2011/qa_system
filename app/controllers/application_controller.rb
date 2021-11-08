class ApplicationController < ActionController::Base
    include AuthHelper

    private
        # Confirms a logged-in user.
        def logged_in_user
            unless logged_in?
                store_location
                flash[:danger] = t('messages.pls_login')
                redirect_to login_url
            end
        end
end
