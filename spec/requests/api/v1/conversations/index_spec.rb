require 'rails_helper'

describe 'GET /api/v1/conversations', type: :request do
  let(:user)   { create(:user) }
  let(:user2)  { create(:user) }

  before(:each) do
    create(:conversation, :with_matching_targets, users: [user, user2], user_id: user.id)
  end

  context 'when the request is valid' do
    subject { get api_v1_conversations_path, headers: auth_headers, as: :json }

    it 'returns the conversations in the correct format' do
      subject
      expect(json['conversations'].first['chat_user'].first['username']).to eq(user2.username)
      expect(json['conversations'].first['chat_user'].first['email']).to eq(user2.email)
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end
  end
end
