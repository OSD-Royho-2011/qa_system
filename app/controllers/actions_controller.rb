  class ActionsController < ApplicationController
    before_action :logged_in_user
    before_action :load_action, only: [:like, :dislike]
    after_action	:ajax_response, only: [:like, :dislike]

    def like
      return @question.actions.likable.create(user: current_user) if @action.nil?
      return @action.change_to_liked if @action.dislikable?
      @action.destroy
    end
  
    def dislike
      return @question.actions.dislikable.create(user: current_user) if @action.nil? 
      return @action.change_to_disliked if @action.likable?
      @action.destroy
    end

    private
      def load_action
        @question = Question.find(params[:id])
        @action = @question.actions.find_by(user_id: current_user.id)
      end

      def ajax_response
        respond_to do |format|
          format.html { redirect_to @question }
          format.js
        end
      end
  end