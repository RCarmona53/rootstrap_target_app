class MessagePolicy < ApplicationPolicy
  def index?
    user_authenticated?
  end

  def create?
    user_authenticated?
  end
end
