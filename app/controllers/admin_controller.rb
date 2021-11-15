class AdminController < ApplicationController
  before_action :logged_in_user
  before_action :load_question, only: [:approve, :close]

  def index
    @questions = Question.all
  end

  def approve
    update_question_status(1)
    redirect_back_or index_path
  end

  def close
    update_question_status(2)
    redirect_back_or index_path
  end

  def management; end

  private
    def load_question
      @question = Question.find(params[:id])
    end

    def update_question_status(code)
      @question.update_attribute(:status, code)
      flash[:success] = t('messages.approve_msg')
      flash[:success] = t('messages.close_msg') if code == 2
    end
end
