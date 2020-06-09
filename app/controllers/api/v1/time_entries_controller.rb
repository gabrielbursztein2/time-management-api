module Api
  module V1
    class TimeEntriesController < Api::V1::ApiController
      helper_method :time_entry

      def index
        @time_entries = current_user.time_entries.in_range(start_date, end_date).order(date: :desc)
      end

      def create
        @time_entry = current_user.time_entries.create!(time_entry_params)
      end

      def update
        @time_entry = time_entry.update!(time_entry_params)
      end

      def destroy
        time_entry.destroy!
      end

      private

      def time_entry
        @time_entry ||= current_user.time_entries.find(params[:id])
      end

      def time_entry_params
        params.require(:time_entry).permit(:detail, :date, :minutes)
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
