describe 'PUT api/v1/time_entries/:id', type: :request do
  let(:old_detail)  { 'Old detail' }
  let!(:time_entry) { create(:time_entry, detail: old_detail) }

  subject do
    put api_v1_admin_time_entry_path(time_entry.id),
        params: params,
        headers: auth_headers,
        as: :json
  end

  context 'when the user has permissions' do
    let(:user) { create(:user, :admin_user) }

    context 'with valid params' do
      let(:new_detail) { 'New detail' }
      let(:params)     { { detail: new_detail } }

      it 'returns success' do
        subject
        expect(response).to be_successful
      end

      it 'updates the time_entry' do
        expect { subject }.to change { time_entry.reload.detail }.from(old_detail).to(new_detail)
      end
    end

    context 'with invalid params' do
      let(:params) { { detail: nil } }

      it 'returns a bad request' do
        subject
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  context 'when the user does not have permissions' do
    let(:user)       { create(:user) }
    let(:new_detail) { 'New detail' }
    let(:params)     { { detail: new_detail } }

    it 'returns unauthorized' do
      subject
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
