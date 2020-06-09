json.user do
  json.partial! 'api/v1/users/info', user: user.reload
end
