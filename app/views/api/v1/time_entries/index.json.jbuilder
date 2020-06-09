json.time_entries do
  json.array! @time_entries, partial: 'info', as: :time_entry
end
