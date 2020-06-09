# == Schema Information
#
# Table name: time_entries
#
#  id         :bigint           not null, primary key
#  detail     :string           not null
#  date       :date             not null
#  minutes    :integer          not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_time_entries_on_user_id  (user_id)
#
class TimeEntry < ApplicationRecord
  belongs_to :user

  validates :detail, :date, :minutes, presence: true
  validates :minutes, numericality: { greater_than: 0 }

  scope :in_range, (lambda do |start_date, end_date|
    if start_date.present? && end_date.present?
      where(date: start_date..end_date)
    else
      all
    end
  end)
end
