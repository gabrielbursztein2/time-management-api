module Api
  module V1
    module Admin
      class UsersController < Api::V1::ApiController
        helper_method :user
        before_action :auth_user, except: :destroy

        def index
          @users = User.all
        end

        def create
          @user = User.create!(user_create_params)
        end

        def update
          user.update!(user_update_params)
        end

        def destroy
          authorize user
          user.destroy!
        end

        private

        def auth_user
          authorize User
        end

        def user
          @user ||= User.find(params[:id])
        end

        def user_create_params
          params.require(:user).permit(:first_name, :last_name, :working_hours, :email,
                                       :role, :password)
        end

        def user_update_params
          params.require(:user).permit(:first_name, :last_name, :working_hours, :role)
        end
      end
    end
  end
end
