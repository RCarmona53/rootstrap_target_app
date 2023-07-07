class CleanupJob < ApplicationJob
  queue_as :default

  def perform
    Target.cleanup_old_targets
  end
end
