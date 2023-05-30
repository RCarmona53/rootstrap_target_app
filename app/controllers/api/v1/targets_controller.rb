module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def create
        authorize Target
        @target = current_user.targets.create!(resource_params)
      end

      def resource_params
        params.require(:target).permit(:title, :lat, :lng, :radius, :topic_id)
      end
    end
  end
end
