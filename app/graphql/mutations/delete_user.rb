module Mutations
  class DeleteUser < BaseMutation
    argument :id, ID, required: true

    field :errors, [String], null: false

    def resolve(id:)
      user = User.find(id)
      
      user.destroy
    rescue ActiveRecord::RecordNotFound => e
      return { user: nil, errors: e }
    end
  end
end
