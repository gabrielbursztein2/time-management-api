describe UserPolicy do
  subject { described_class }

  permissions :index? do
    context 'when the user is not a user_manager' do
      let(:user) { create(:user) }

      it 'denies access' do
        expect(subject).not_to permit(user)
      end
    end

    context 'when the user is a user_manager' do
      let(:user) { create(:user, :user_manager) }

      it 'allow access' do
        expect(subject).to permit(user)
      end
    end
  end

  permissions :create? do
    context 'when the user is not a user_manager' do
      let(:user) { create(:user) }

      it 'denies access' do
        expect(subject).not_to permit(user)
      end
    end

    context 'when the user is a user_manager' do
      let(:user) { create(:user, :user_manager) }

      it 'allow access' do
        expect(subject).to permit(user)
      end
    end
  end

  permissions :update? do
    context 'when the user is not a user_manager' do
      let(:user1) { create(:user) }
      let(:user2) { create(:user) }

      it 'denies access' do
        expect(subject).not_to permit(user1, user2)
      end
    end

    context 'when the user is a user_manager' do
      let(:user1) { create(:user, :user_manager) }
      let(:user2) { create(:user) }

      it 'allow access' do
        expect(subject).to permit(user1, user2)
      end
    end
  end

  permissions :destroy? do
    context 'when the user is not a user_manager' do
      let(:user1) { create(:user) }
      let(:user2) { create(:user) }

      it 'denies access' do
        expect(subject).not_to permit(user1, user2)
      end
    end

    context 'when the user is a user_manager' do
      let(:user1) { create(:user, :user_manager) }
      let(:user2) { create(:user) }

      it 'allow access' do
        expect(subject).to permit(user1, user2)
      end
    end
  end
end
