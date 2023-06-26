require 'rails_helper'

RSpec.describe 'Admin Targets', type: :request do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  before do
    sign_in admin_user
  end

  describe 'GET /admin/targets' do
    it 'filters targets by topic' do
      topic1 = FactoryBot.create(:topic, name: 'Topic 1')
      topic2 = FactoryBot.create(:topic, name: 'Topic 2')

      target1 = FactoryBot.create(:target, title: 'Target 1', topic: topic1)
      target2 = FactoryBot.create(:target, title: 'Target 2', topic: topic2)

      get '/admin/targets', params: { q: { topic_id_eq: topic1.id } }

      expect(response).to be_successful

      expect(response.body).to include(target1.title)
      expect(response.body).not_to include(target2.title)
    end
  end
end
