module Api
  module V1
    class UsersController < Api::V1::ApiController
      def update
        current_user.update!(user_params)
      end

      private

      def user_params
        params.require(:user).permit(:working_hours)
      end
    end
  end
end
