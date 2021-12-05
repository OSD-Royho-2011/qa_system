module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users, [Types::UserType], null: false, description: "Returns a list of users"

    def users
      User.all
    end

    field :user, Types::UserType, null: false, description: "Returns a single record of user" do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

  end
end
