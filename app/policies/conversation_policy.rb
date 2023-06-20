class ConversationPolicy < ApplicationPolicy
  def index?
    user_authenticated?
  end
end
