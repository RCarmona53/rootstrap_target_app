class TargetPolicy < ApplicationPolicy
  def create?
    true
  end

  def index?
    true
  end

  def destroy?
    true
  end
end
