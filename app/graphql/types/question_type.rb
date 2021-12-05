module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :private_token, String, null: true
    field :content, String, null: true
    field :status, Integer, null: true
    field :user_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :categories, [Types::CategoryType], null: true
  end
end
