describe 'DELETE api/v1/targets/:id', type: :request do
  let!(:user)               { create(:user) }
  let!(:user_targets)       { create_list(:target, 3, user:) }
  let!(:other_targets)      { create_list(:target, 3) }
  let(:first_target_user)   { user_targets.first }
  let(:id)                  { first_target_user.id }
  subject { delete api_v1_target_path(id:), headers: auth_headers, as: :json }

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'deletes the target' do
    expect { subject }.to change(user.targets, :count).by(-1)
  end

  context 'when trying to delete a target from another user' do
    let(:id) { other_targets.first.id }

    it 'does not delete a target' do
      expect { subject }.not_to change { Target.count }
    end

    it 'does not return a successful response' do
      subject
      expect(response).to be_not_found
    end
  end

  context 'when the id is not valid' do
    let(:id) { 'invalid_id' }

    it 'does not delete a target' do
      expect { subject }.not_to change { Target.count }
    end

    it 'does not return a successful response' do
      subject
      expect(response).to be_not_found
    end
  end

  it 'returns the deleted target in correct format' do
    subject
    expect(json[:target][:id]).to eq(first_target_user.id)
    expect(json[:target][:title]).to eq(first_target_user.title)
    expect(json[:target][:radius]).to eq(first_target_user.radius)
    expect(json[:target][:lat].round(10)).to eq(first_target_user.lat.round(10))
    expect(json[:target][:lng].round(10)).to eq(first_target_user.lng.round(10))
    expect(json[:target][:topic_id]).to eq(first_target_user.topic_id)
  end
end
