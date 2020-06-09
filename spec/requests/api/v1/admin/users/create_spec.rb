describe 'POST api/v1/admin/users', type: :request do
  let(:params)   { { user: attributes_for(:user) } }
  let(:new_user) { User.last }

  subject { post api_v1_admin_users_path, params: params, headers: auth_headers, as: :json }

  context 'when the user has permissions' do
    let!(:user) { create(:user, :user_manager) }

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'creates the user' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'returns the user' do
      subject

      expect(json[:user]).to include_json(
        id: new_user.id,
        email: new_user.email,
        first_name: new_user.first_name,
        last_name: new_user.last_name
      )
    end

    context 'when the email is not correct' do
      let(:params) { { user: attributes_for(:user, email: 'invalid_email') } }

      it 'does not create a user' do
        expect { subject }.not_to change(User, :count)
      end

      it 'does not return a successful response' do
        subject

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the password is incorrect' do
      let(:params) { { user: attributes_for(:user, password: 'short') } }

      it 'does not create a user' do
        subject
        expect { subject }.not_to change(User, :count)
      end

      it 'does not return a successful response' do
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
