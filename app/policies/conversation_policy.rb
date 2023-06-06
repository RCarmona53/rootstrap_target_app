class ConversationPolicy < ApplicationPolicy
  def index?
    user_authenticated?
  end

  private

  def user_authenticated?
    user.present?
  end
end
