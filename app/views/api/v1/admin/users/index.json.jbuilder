json.users do
  json.array! @users, partial: 'api/v1/users/info', as: :user
end
