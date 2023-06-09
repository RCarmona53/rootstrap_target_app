describe 'GET api/v1/targets', type: :request do
  let!(:user)               { create(:user) }
  let!(:user_targets)       { create_list(:target, 3, user:) }
  let!(:targets)            { create_list(:target, 5) }
  let(:first_target_user)   { user_targets.first }
  subject { get api_v1_targets_path, headers: auth_headers, as: :json }

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'returns all targets from specific user' do
    subject
    expect(json[:targets].pluck(:id)).to match_array(user_targets.pluck(:id))
  end

  it 'returns the targets in the correct format' do
    subject
    expect(json[:targets].first[:id]).to eq(first_target_user.id)
    expect(json[:targets].first[:title]).to eq(first_target_user.title)
    expect(json[:targets].first[:radius]).to eq(first_target_user.radius)
    expect(json[:targets].first[:lat].round(10)).to eq(first_target_user.lat.round(10))
    expect(json[:targets].first[:lng].round(10)).to eq(first_target_user.lng.round(10))
    expect(json[:targets].first[:topic_id]).to eq(first_target_user.topic_id)
  end
end
