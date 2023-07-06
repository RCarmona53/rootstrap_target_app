class CleanupJob < ApplicationJob
  queue_as :default

  def perform
    Target.where('created_at <= ?', 1.week.ago).destroy_all
  end
end
