describe 'DELETE api/v1/time_entries/:id', type: :request do
  let!(:time_entry) { create(:time_entry) }

  subject do
    delete api_v1_admin_time_entry_path(time_entry.id), headers: auth_headers, as: :json
  end

  context 'when the user has permissions' do
    let!(:user) { create(:user, :admin_user) }

    it 'destroys the time_entry' do
      expect { subject }.to change(TimeEntry, :count).by(-1)
    end
  end

  context 'when the user does not have permissions' do
    let(:user) { create(:user) }

    it 'returns unauthorized' do
      subject
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
