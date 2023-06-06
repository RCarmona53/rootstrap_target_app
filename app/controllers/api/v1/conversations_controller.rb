module Api
  module V1
    class ConversationsController < Api::V1::ApiController
      def index
        @conversations = policy_scope(current_user.conversations)
      end
    end
  end
end
