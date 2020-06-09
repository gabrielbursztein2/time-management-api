describe 'POST api/v1/time_entries', type: :request do
  let(:user2)  { create(:user) }
  let(:params) { attributes_for(:time_entry).merge(user_id: user2.id) }

  subject do
    post api_v1_admin_time_entries_path, params: params, headers: auth_headers, as: :json
  end

  context 'when the user has permissions' do
    let(:user) { create(:user, :admin_user) }

    context 'with valid params' do
      it 'creates the time entry' do
        expect { subject }.to change(TimeEntry, :count).by(1)
      end

      it 'assigns the time_entry to the logged user' do
        expect { subject }.to change(TimeEntry, :count).by(1)
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

  context 'when the user does not have permissions' do
    let(:user) { create(:user) }

    it 'returns unauthorized' do
      subject
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
