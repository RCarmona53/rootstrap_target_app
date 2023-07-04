require 'rails_helper'

RSpec.describe 'Admin Users', type: :request do
  let(:admin_user) { create(:admin_user) }

  before do
    sign_in admin_user
  end

  describe 'Show all users' do
    let!(:user1) { create(:user, email: 'user1@example.com') }
    let!(:user2) { create(:user, email: 'user2@example.com') }

    it 'displays all users for the admin user' do
      get '/admin/users'

      expect(response).to be_successful

      expect(response.body).to include(user1.email)
      expect(response.body).to include(user2.email)
    end
  end

  describe 'Promote to VIP' do
    let(:user) { create(:user, vip: false) }
    it 'updates the VIP status of the user' do
      put "/admin/users/#{user.id}", params: { user: { vip: true } }

      expect(response).to redirect_to(admin_user_path(user))
      expect(user.reload.vip).to be true
    end
  end
end
