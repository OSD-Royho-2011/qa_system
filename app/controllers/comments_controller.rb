class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :load_question, only: [:create]
  before_action :load_comment, except: [:create]
  after_action	:ajax_response

  def create
    @comment = @question.comments.build(comment_params)
    @comment.private_token = encrypt(current_user.id) if current_user.cognito?
    @comment.user = current_user if !current_user.cognito?
    @comment.parent = Comment.find_by_id(params[:parent_id]) if params[:comment].present?
    @comment.save
  end

  def update
    @comment.update_attribute(:content, params[:comment][:content])
    @question = Question.find(@comment.question_id)
  end

  def destroy
    @question = Question.find(@comment.question_id)
    @comment.destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def load_question
      @question = Question.find(params[:id])
    end

    def load_comment
      @comment = Comment.find(params[:id])
    end

    def ajax_response
      respond_to do |format|
        format.html { redirect_to @question }
        format.js
      end
    end
end
