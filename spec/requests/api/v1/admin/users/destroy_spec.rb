describe 'DELETE api/v1/admin/users/:id', type: :request do
  let!(:user2) { create(:user) }
  let(:id)     { user2.id }

  subject { delete api_v1_admin_user_path(id), headers: auth_headers, as: :json }

  context 'when the user has permissions' do
    let!(:user) { create(:user, :user_manager) }

    it 'returns success' do
      subject
      expect(response).to be_successful
    end

    it 'destroys the user' do
      expect { subject }.to change(User, :count).by(-1)
    end

    context 'when trying to delete itself' do
      let(:id) { user.id }

      it 'returns unauthorized error' do
        subject
        expect(response).to have_http_status(:unauthorized)
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
