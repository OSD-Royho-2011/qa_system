module Mutations
  class UpdateUser < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :email, String, required: false
    argument :password, String, required: false
    argument :password_confirmation, String, required: false
    argument :role_id, Integer, required: false

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(id:, **arg)
      user = User.find(id)
      if user.update(arg)
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
    rescue ActiveRecord::RecordNotFound
      return { user: nil, errors: ['record-not-found'] }
    end
  end
end
