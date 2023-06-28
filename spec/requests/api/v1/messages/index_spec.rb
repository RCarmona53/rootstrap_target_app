describe 'GET /api/v1/conversations/:conversation_id/messages', type: :request do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation_with_users, user1: user) }
  let(:messages) { create_list(:message, 5, conversation:) }

  context 'when the request is valid' do
    subject do
      get api_v1_conversation_messages_path(conversation),
          headers: auth_headers,
          as: :json
    end

    before { messages }

    it 'returns a list of messages for the conversation' do
      subject
      expect(json['messages'].length).to eq(5)
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'returns the messages in the correct format' do
      subject
      expect(json[:messages].first[:id]).to eq(messages.first.id)
      expect(json[:messages].first[:content]).to eq(messages.first.content)
    end
  end
end
