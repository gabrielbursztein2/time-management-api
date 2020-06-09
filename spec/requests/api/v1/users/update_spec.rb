describe 'PUT api/v1/users/:id', type: :request do
  let(:user) { create(:user) }

  subject do
    put api_v1_user_path(user.id), params: params, headers: auth_headers, as: :json
  end

  context 'with valid params' do
    let(:params) { { user: { working_hours: 6 } } }

    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'updates the user' do
      subject
      expect(user.reload.working_hours).to eq(params[:user][:working_hours])
    end

    it 'returns the user' do
      subject
      expect(json[:user][:id]).to eq user.id
      expect(json[:user][:full_name]).to eq user.reload.full_name
    end
  end
end
