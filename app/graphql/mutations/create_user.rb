module Mutations
  class CreateUser < BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true
    argument :role_id, Integer, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(**arg)
      user = User.new(arg)
      if user.save
        {
          user: user,
          errors: []
        }
      else
        {
          user: nil,
          errors: user.errors.full_messages
        }
      end
    end
  end
end
