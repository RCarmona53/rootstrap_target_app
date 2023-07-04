class TargetPolicy < ApplicationPolicy
  def create?
    user_authenticated?
  end

  def index?
    user_authenticated?
  end

  def destroy?
    user_authenticated? && target_belongs_to_user?
  end

  private

  def target_belongs_to_user?
    record.user == user
  end
end
