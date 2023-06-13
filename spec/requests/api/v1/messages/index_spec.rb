describe 'GET /api/v1/conversations/:conversation_id/messages', type: :request do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation, user_id: user.id) }

  before(:each) do
    conversation.users << user
  end

  context 'when the request is valid' do
    subject do
      get api_v1_conversation_messages_path(conversation),
          headers: auth_headers,
          as: :json
    end

    it 'returns a list of messages for the conversation' do
      create_list(:message, 5, conversation:)

      subject
      expect(json['messages'].length).to eq(5)
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end
  end
end