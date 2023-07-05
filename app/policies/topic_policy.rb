class TopicPolicy < ApplicationPolicy
  def index?
    user_authenticated?
  end
end
