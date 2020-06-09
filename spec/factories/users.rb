# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  first_name             :string           default("")
#  last_name              :string           default("")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  tokens                 :json
#  working_hours          :integer          default(8), not null
#  role                   :integer          default(0), not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

FactoryBot.define do
  factory :user do
    email         { Faker::Internet.unique.email }
    password      { Faker::Internet.password(min_length: 8) }
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    uid           { Faker::Internet.uuid }
    working_hours { 8 }

    trait :user_manager do
      role { 1 }
    end

    trait :admin_user do
      role { 2 }
    end
  end
end
