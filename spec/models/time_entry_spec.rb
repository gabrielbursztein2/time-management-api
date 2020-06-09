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
require 'rails_helper'

describe TimeEntry do
  describe 'validations' do
    subject { build :time_entry }

    it { is_expected.to validate_presence_of(:minutes) }
    it { is_expected.to validate_numericality_of(:minutes).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:detail) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
