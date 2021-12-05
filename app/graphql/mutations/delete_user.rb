module Mutations
  class DeleteUser < BaseMutation
    argument :id, ID, required: true

    field :errors, [String], null: false

    def resolve(id:, **arg)
      user = User.find(id)
      if user.present? && user.destroy
        {
          errors: []
        }
      else
        {
          errors: ['record-not-found']
        }
      end
    rescue ActiveRecord::RecordNotFound
      return { user: nil, errors: ['record-not-found'] }
    end
  end
end
