describe 'POST api/v1/targets', type: :request do
  let(:user)            { create(:user) }
  let(:topic)           { create(:topic) }
  let(:target)          { Target.last }
  let(:failed_response) { 400 }

  describe 'POST create' do
    subject { post api_v1_targets_path, params:, headers: auth_headers, as: :json }
    let(:title)           { 'test' }
    let(:radius)          { 5 }
    let(:lat)             { -33.8866 }
    let(:lng)             { -58.6688 }
    let(:topic_id)        { topic.id }

    let(:params) do
      {
        title:,
        radius:,
        lat:,
        lng:,
        topic_id:
      }
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'returns the target' do
      subject
      expect(json[:target][:title]).to eq(target.title)
      expect(json[:target][:radius]).to eq(target.radius)
      expect(json[:target][:lat]).to eq(target.lat)
      expect(json[:target][:lng]).to eq(target.lng)
      expect(json[:target][:topic_id]).to eq(target.topic_id)
    end

    it 'creates the target' do
      expect { subject }.to change(Target, :count).from(0).to(1)
    end

    context 'when radius is incorrect' do
      let(:radius) { 'invalid_radius' }

      it 'does not create a target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response.status).to eq(failed_response)
      end
    end

    context 'when the topic id is not correct' do
      let(:topic_id) { 'invalid_topic_id' }

      it 'does not create a target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response.status).to eq(failed_response)
      end
    end

    context 'when latitude or longitude is incorrect' do
      let(:lat) { 'invalid_lat' }
      let(:lng) { 'invalid_lng' }

      it 'does not create a target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response.status).to eq(failed_response)
      end
    end

    context 'when the user has reached the maximum number of targets' do
      let!(:user_targets)  { create_list(:target, 3, user:) }

      it 'does not create a target' do
        expect { subject }.not_to change { Target.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response.status).to eq(failed_response)
      end

      it 'returns an error message' do
        subject
        expect(json[:errors][:user].first).to eq(
          I18n.t('api.errors.max_targets_reached', max_targets: 3)
        )
      end
    end
  end
end
