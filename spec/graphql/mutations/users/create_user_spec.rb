require 'rails_helper'

RSpec.describe ::Mutations::CreateUser do
  let(:query_string) do
    <<~GRAPHQL
      mutation ($input: CreateUserInput!){
        createUser(input: $input)
        {
          user {
            name
          }
          errors
        }
      }
    GRAPHQL
  end

  let(:response) { QaSystemSchema.execute(query_string, variables: variables) }
  let(:admin_role) do
    Role.create(name: "Test")
  end 

  it 'create user successfully' do
    expect do
      variables = {
        input: {
          name: "abc",
          email: "test",
          password: "@bc12354",
          passwordConfirmation: "@bc12354",
          roleId: 3,
        }
      }
      expect(response.to_h.deep_symbolize_keys).to match(
        data: {
          createUser: {
            user: {
              name: "abc"
            },
            errors: [],
          }
        }
      )
    end
  end

  context 'when args is invalid' do
    it 'return a error' do
      expect do
        variables = {
          input: {
            name: "abc",
            email: "test",
            password: "@bc12354",
            passwordConfirmation: "@bc12354",
            roleId: 3,
          }
        }
        expect(response.to_h.deep_symbolize_keys).to match(
          data: {
            createUser: {
              user: nil,
              errors: ["Email is invalid"],
            }
          }
        )
      end
    end
  end
end