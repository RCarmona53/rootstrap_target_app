require 'rails_helper'

RSpec.describe 'Admin Users', type: :request do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  before do
    sign_in admin_user
  end

  describe 'Show all users' do
    it 'displays all users for the admin user' do
      user1 = FactoryBot.create(:user, email: 'user1@example.com')
      user2 = FactoryBot.create(:user, email: 'user2@example.com')

      get '/admin/users'

      expect(response).to have_http_status(200)

      expect(response.body).to include(user1.email)
      expect(response.body).to include(user2.email)
    end
  end
end
