require 'spec_helper'

describe Rufus::Scheduler::EveryJob do
  before :each do
    @scheduler = Rufus::Scheduler.new
  end
  after :each do
    @scheduler.shutdown
  end

  it 'triggers as expected' do
    sum = 0

    @scheduler.in '1s' do
      sum += 5
    end

    sleep 2
    expect(sum).to eq(5)
  end

  let!(:user)               { create(:user) }
  let!(:targets)            { create_list(:target, 3, user:) }
  let(:last_target)         { targets.last }

  it 'deletes the target after given time' do
    @scheduler.in '10s' do
      last_target.destroy
    end
    sleep 15
    expect { last_target.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
