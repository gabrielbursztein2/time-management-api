describe 'PUT api/v1/admin/users/:id', type: :request do
  let(:user2) { create(:user) }
  let(:params) { { user: { first_name: 'first_name' } } }

  subject do
    put api_v1_admin_user_path(user2.id), params: params, headers: auth_headers, as: :json
  end

  context 'when the user has permissions' do
    let(:user) { create(:user, :user_manager) }

    it 'returns success' do
      subject
      expect(response).to be_successful
    end

    it 'updates the user' do
      subject
      expect(user2.reload.first_name).to eq(params[:user][:first_name])
    end

    it 'returns the user' do
      subject
      expect(json[:user][:id]).to eq user2.id
      expect(json[:user][:full_name]).to eq user2.reload.full_name
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
