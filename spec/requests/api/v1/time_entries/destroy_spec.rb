describe 'DELETE api/v1/time_entries/:id', type: :request do
  let!(:user)       { create(:user) }
  let!(:time_entry) { create(:time_entry, user: user) }

  subject do
    delete api_v1_time_entry_path(time_entry.id), headers: auth_headers, as: :json
  end

  it 'destroys the time_entry' do
    expect { subject }.to change(TimeEntry, :count).by(-1)
  end
end
