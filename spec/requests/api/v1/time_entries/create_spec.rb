describe 'POST api/v1/time_entries', type: :request do
  let!(:user) { create(:user) }

  subject { post api_v1_time_entries_path, params: params, headers: auth_headers, as: :json }

  context 'with valid params' do
    let(:params) { attributes_for(:time_entry) }

    it 'creates the time entry' do
      expect { subject }.to change(TimeEntry, :count).by(1)
    end

    it 'assigns the time_entry to the logged user' do
      expect { subject }.to change { user.reload.time_entries.count }.by(1)
    end
  end

  context 'with invalid params' do
    let(:params) { { minutes: 300, date: Time.zone.today.to_s } }

    it 'return bad request' do
      subject
      expect(response).to have_http_status(:bad_request)
    end
  end
end
