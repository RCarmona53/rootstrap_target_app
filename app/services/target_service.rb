class TargetService
  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def create!
    targets.create!(@params)
  end

  private

  def targets
    @targets ||= @current_user.targets
  end
end
