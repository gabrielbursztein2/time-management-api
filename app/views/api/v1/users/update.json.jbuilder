json.user do
  json.partial! 'info', user: current_user.reload
end
