module Api
  module V1
    class TopicsController < ApplicationController
      def index
        @topics = policy_scope(Topic).includes(image_attachment: :blob)
        respond_to do |format|
          format.json
        end
      end
    end
  end
end
