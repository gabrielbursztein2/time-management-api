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
FactoryBot.define do
  factory :time_entry do
    user
    detail  { Faker::Lorem.sentence }
    minutes { 60 }
    date    { Faker::Date.backward(days: 5) }
  end
end
