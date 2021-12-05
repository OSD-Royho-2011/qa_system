module Types
  class ActionType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :question_id, Integer, null: false
    field :action, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
