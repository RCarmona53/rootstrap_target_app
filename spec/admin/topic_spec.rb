describe 'Admin Topics', type: :request do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:topic) { FactoryBot.create(:topic, name: 'Old Topic') }

  before do
    sign_in admin_user
  end

  describe 'Create a new topic' do
    it 'creates a new topic with a random image' do
      image = StringIO.new(Faker::LoremPixel.image)

      blob = ActiveStorage::Blob.create_and_upload!(
        io: image,
        filename: 'random_image.png',
        content_type: 'image/png'
      )

      expect {
        post '/admin/topics', params: {
          topic: {
            name: 'New Topic',
            image: blob.signed_id
          }
        }
      }.to change { Topic.count }.by(1)

      new_topic = Topic.last
      expect(new_topic.name).to eq('New Topic')
      expect(response).to redirect_to(admin_topic_path(new_topic))
    end
  end

  describe 'Edit an existing topic' do
    it 'edits an existing topic' do
      put "/admin/topics/#{topic.id}", params: { topic: { name: 'Updated Topic' } }

      expect(response).to redirect_to(admin_topic_path(topic.id))
      expect(topic.reload.name).to eq('Updated Topic')
    end
  end

  describe 'Delete an existing topic' do
    it 'deletes an existing topic' do
      expect {
        delete "/admin/topics/#{topic.id}"
      }.to change { Topic.count }.from(1).to(0)

      expect(response).to redirect_to(admin_topics_path)
    end
  end
end
