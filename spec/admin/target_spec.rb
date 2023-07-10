require 'rails_helper'

RSpec.describe 'Admin Targets', type: :request do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  before do
    sign_in admin_user
  end

  describe 'GET /admin/targets' do
    it 'displays all targets for the admin user' do
      target1 = FactoryBot.create(:target, title: 'Target 1')
      target2 = FactoryBot.create(:target, title: 'Target 2')

      get '/admin/targets'

      expect(response).to be_successful

      expect(response.body).to include(target1.title)
      expect(response.body).to include(target2.title)
    end
  end
end
