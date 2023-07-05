describe 'POST /api/v1/conversations/:conversation_id/messages', type: :request do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation_with_users, user1: user) }
  let(:message) do
    create(:message, content: 'Message Test', conversation_id: conversation.id, user_id: user.id)
  end
  let(:valid_params) do
    {
      user_id: user.id,
      content: 'Message Test',
      conversation_id: conversation.id
    }
  end

  subject do
    post "/api/v1/conversations/#{conversation.id}/messages",
         params:,
         headers: auth_headers,
         as: :json
  end

  context 'when the request is valid' do
    let(:params) { valid_params }

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'creates the message' do
      expect { subject }.to change(Message, :count)
    end

    it 'returns the message in the correct format' do
      subject
      expect(json[:content]).to eq(message.content)
    end
  end

  context 'when the user does not belong to the conversation' do
    let(:other_user) { create(:user) }
    let(:other_conversation) { create(:conversation_with_users, user1: other_user) }
    let(:params) do
      valid_params.merge(conversation_id: other_conversation.id)
    end

    it 'does not create the message' do
      expect { subject }.not_to change { other_conversation.messages.count }
    end
  end

  context 'when the content of the message is missing' do
    let(:params) { valid_params.merge(content: '') }

    it 'does not create the message' do
      subject
      expect(response).to be_bad_request
    end
  end

  context 'when the content of the message exceeds the allowed length' do
    let(:long_content) { 'a' * (Message::MAX_CONTENT_LENGTH + 1) }
    let(:params) { valid_params.merge(content: long_content) }

    it 'does not create the message' do
      expect { subject }.not_to change(Message, :count)
    end

    it 'returns a bad request response' do
      subject
      expect(response).to be_bad_request
    end
  end
end
