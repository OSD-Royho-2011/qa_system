module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :password_digest, String, null: true
    field :remember_digest, String, null: true
    field :activation_digest, String, null: true
    field :activated, Boolean, null: true
    field :activated_at, GraphQL::Types::ISO8601DateTime, null: true
    field :reset_digest, String, null: true
    field :reset_sent_at, GraphQL::Types::ISO8601DateTime, null: true
    field :cognito, Boolean, null: true
    field :role_id, Integer, null: true
    field :questions, [Types::QuestionType], null: true
    field :question_count, Integer, null: true

    def question_count
      object.questions.size
    end
  end
end
