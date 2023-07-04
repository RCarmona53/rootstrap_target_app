module Api
  module V1
    class MessagesController < Api::V1::ApiController
      def index
        @messages = policy_scope(conversation.messages).includes(:user)
      end

      def create
        @message = build_message

        authorize @message

        if save_message
          render json: { message: { content: @message.content } }, status: :created
        else
          render json: { errors: @message.errors.full_messages }, status: :bad_request
        end
      end

      private

      def message_params
        params.require(:message).permit(:content)
      end

      def conversation
        current_user.conversations.find(params[:conversation_id])
      end

      def build_message
        conversation.messages.new(message_params).tap do |message|
          message.user = current_user
        end
      end

      def save_message
        @message.save
      end
    end
  end
end
