json.time_entries do
  json.array! @time_entries, partial: 'api/v1/time_entries/info', as: :time_entry
end
