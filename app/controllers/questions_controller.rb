class QuestionsController < ApplicationController
  include QuestionsAction
  before_action :logged_in_user
  load_and_authorize_resource
  before_action :load_permissions
  before_action :load_question, except: [:index, :create]
  before_action :load_categories, only: [:index, :edit]
  before_action :build_question, only: [:index]
  before_action :build_comment, only: [:show]
  before_action :load_action, only: [:like, :dislike]
  after_action	:ajax_response, only: [:like, :dislike]

  def index
    @questions = Question.approved
  end

  def create
    if current_user.cognito?
      @question = Question.new(question_params)
      @question.private_token = encrypt(current_user.id)
    else
      @question = current_user.questions.build(question_params)
    end
    store_question(@question)
  end

  def show
    return @question if !current_user.member?
    return @question if @question.waiting? && is_owner(@question)
    return @question if @question.approved?
    flash[:danger] = t('messages.no_permission')
    redirect_to root_url
  end

  def edit; end

  def update
    if @question.update(question_params)
      flash[:success] = t('messages.question_update')
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:primary] = t('messages.question_deleted')
    redirect_to root_url
  end

  def approve
    @question.change_to_approved
    flash[:success] = t('messages.approve_msg')
    redirect_back_or index_path
  end

  def close
    @question.change_to_closed
    flash[:success] = t('messages.close_msg')
    redirect_back_or index_path
  end

  def like
    return if @question.waiting? && current_user.member?
    return @question.actions.likable.create(user: current_user) if @action.nil?
    return @action.change_to_liked if @action.dislikable?
    @action.destroy
  end

  def dislike
    return if @question.waiting? && current_user.member?
    return @question.actions.dislikable.create(user: current_user) if @action.nil? 
    return @action.change_to_disliked if @action.likable?
    @action.destroy
  end

  private
    def question_params
      params.require(:question).permit(:content, {:category_ids => []}, :image)
    end

    # Store question and redirect to preview mode
    def store_question(question)
      @question.image.attach(params[:question][:image])
      if question.save
        flash[:primary] = t('messages.post_success')
        redirect_to question
      else
        flash[:danger] = t('messages.post_failed')
        redirect_to root_path
      end
    end

    def load_question
      @question = Question.find_by(id: params[:id])
      return if @question.present?
      flash[:danger] = t('messages.question_not_exist')
      redirect_to root_url
    end

    def load_categories
      @categories = Category.all
    end

    def build_question
      @question = Question.new
    end

    def build_comment
      @comment = Comment.new
    end

    def load_action
      @action = @question.actions.find_by(user_id: current_user.id)
    end

    def ajax_response
      respond_to do |format|
        format.html { redirect_to @question }
        format.js
      end
    end
end
