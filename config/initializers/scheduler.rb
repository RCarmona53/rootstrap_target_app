require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '1d' do
  Target.where('created_at <= ?', 1.week.ago).destroy_all
end
