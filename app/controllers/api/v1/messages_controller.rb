module Api
  module V1
    class MessagesController < Api::V1::ApiController
      def index
        conversation = find_conversation
        @messages = policy_scope(conversation.messages)
        render_messages(@messages)
      end

      def create
        conversation = find_conversation
        message = build_message(conversation)

        authorize message

        if save_message(message)
          render_created_message(message)
        else
          render_error(message)
        end
      end

      private

      def message_params
        params.require(:message).permit(:content)
      end

      def find_conversation
        current_user.conversations.find(params[:conversation_id])
      end

      def build_message(conversation)
        conversation.messages.build(message_params.merge(user: current_user))
      end

      def save_message(message)
        message.save
      end

      def render_messages(messages)
        render json: { messages: }, status: :ok
      end

      def render_created_message(message)
        render json: { message: { content: message.content } }, status: :created
      end

      def render_error(message)
        render json: { errors: message.errors.full_messages }, status: :bad_request
      end
    end
  end
end
