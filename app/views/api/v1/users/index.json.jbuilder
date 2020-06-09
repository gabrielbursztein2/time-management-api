json.users do
  json.array! @users, partial: 'info', as: :user
end
