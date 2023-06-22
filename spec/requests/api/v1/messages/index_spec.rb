DEFAULT_PER_PAGE = 5

describe 'GET /api/v1/conversations/:conversation_id/messages', type: :request do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation_with_users, user1: user) }
  let!(:messages) { create_list(:message, 5, conversation:) }

  subject(:get_messages) do
    get api_v1_conversation_messages_path(conversation),
        headers: auth_headers,
        params: { 'page' => per_page },
        as: :json
  end

  shared_context 'with page param' do |page|
    let(:per_page) { page.to_s }

    before { get_messages }
  end

  context 'when the request is valid' do
    include_context 'with page param', 1

    it 'returns a list of messages for the conversation' do
      expect(json['messages'].length).to eq(5)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns the messages in the correct format' do
      expect(json['messages'].first['id']).to eq(messages.first.id)
      expect(json['messages'].first['content']).to eq(messages.first.content)
    end

    context 'when paginating the messages' do
      let!(:more_messages) { create_list(:message, 10, conversation:) }

      include_context 'with page param', 1

      it 'paginates the messages for page 1' do
        expect(response).to be_successful
        expect(json['messages'].length).to eq(5)
      end

      it 'returns a successful response for page 1' do
        expect(response).to be_successful
      end

      include_context 'with page param', 2

      it 'paginates the messages for page 2' do
        expect(response).to be_successful
      end

      it 'returns a successful response for page 2' do
        expect(response).to be_successful
      end
    end

    context 'when the request does not include per_page param' do
      before do
        get api_v1_conversation_messages_path(conversation),
            headers: auth_headers,
            as: :json
      end

      it 'returns a list of messages for the conversation' do
        expect(json['messages'].length).to eq(DEFAULT_PER_PAGE)
      end
    end

    context 'when the request includes per_page param with excessive value' do
      let(:excessive_per_page) { 1_000_000 }

      before do
        get api_v1_conversation_messages_path(conversation),
            headers: auth_headers,
            params: { 'page' => '1', 'per_page' => excessive_per_page },
            as: :json
      end

      it 'limits the per_page value to a maximum' do
        expect(response).to be_successful
        expect(json['messages'].length).to eq(DEFAULT_PER_PAGE)
      end
    end
  end
end
