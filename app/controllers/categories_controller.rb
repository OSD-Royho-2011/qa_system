class CategoriesController < ApplicationController
  before_action :logged_in_user
  load_and_authorize_resource
  before_action :load_permissions
  before_action :build_category, only: [:index]
  before_action :load_category, except: [:index, :create]

  def index
    @categories = Category.all
  end

  def create 
    @category = Category.new(category_params)
    flash[:success] = t('messages.add_category_success') if @category.save
    redirect_back_or categories_path
  end

  def update
    flash[:success] = t('messages.update_category_success') if @category.update(category_params)
    redirect_back_or categories_path
  end

  def destroy
    flash[:success] = t('messages.delete_category_success') if @category.destroy
    redirect_back_or categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name, :description)
    end

    def build_category
      @category = Category.new
    end

    def load_category
      @category = Category.find(params[:id])
      return if @category.present?
      flash[:danger] = t('messages.category_not_exist')
      redirect_to categories_path
    end

end
