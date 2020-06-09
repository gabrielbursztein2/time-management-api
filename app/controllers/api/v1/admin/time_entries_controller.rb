module Api
  module V1
    module Admin
      class TimeEntriesController < Api::V1::ApiController
        helper_method :time_entry
        before_action :auth_user

        def index
          @time_entries = TimeEntry.in_range(start_date, end_date)
                                   .order(date: :desc)
                                   .includes(:user)
        end

        def create
          @time_entry = TimeEntry.create!(time_entry_params)
        end

        def update
          @time_entry = time_entry.update!(time_entry_params)
        end

        def destroy
          time_entry.destroy!
        end

        private

        def auth_user
          authorize TimeEntry
        end

        def time_entry
          @time_entry ||= TimeEntry.find(params[:id])
        end

        def time_entry_params
          params.require(:time_entry).permit(:user_id, :detail, :date, :minutes)
        end

        def start_date
          params[:start_date]
        end

        def end_date
          params[:end_date]
        end
      end
    end
  end
end
