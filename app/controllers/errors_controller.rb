class ErrorsController < ApplicationController
  def error_404
    render 'errors/page_404'
  end
end
