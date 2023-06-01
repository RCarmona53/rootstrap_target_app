class TargetPolicy < ApplicationPolicy
  def create?
    true
  end

  def index?
    true
  end

  def destroy?
    user_authenticated? && target_belongs_to_user?
  end

  private

  def user_authenticated?
    user.present?
  end

  def target_belongs_to_user?
    record.user == user
  end
end
