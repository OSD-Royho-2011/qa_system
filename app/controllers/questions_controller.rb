class QuestionsController < ApplicationController
	before_action :logged_in_user, only: [:index, :detail]

	def index; end

	def detail; end
end
