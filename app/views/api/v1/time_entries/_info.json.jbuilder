json.id      time_entry.id
json.detail  time_entry.detail
json.minutes time_entry.minutes
json.date    time_entry.date.iso8601
json.user do
  json.partial! 'api/v1/users/info', user: time_entry.user
end
