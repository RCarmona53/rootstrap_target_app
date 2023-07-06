require 'rails_helper'

RSpec.describe CleanupJob, type: :job do
  let!(:user) { create(:user) }
  let!(:targets) { create_list(:target, 2, user:) }
  let!(:old_target) { create(:target, user:, created_at: 2.weeks.ago) }

  it 'deletes targets older than one week' do
    expect { CleanupJob.perform_now }.to change { Target.count }.by(-1)
  end
end
