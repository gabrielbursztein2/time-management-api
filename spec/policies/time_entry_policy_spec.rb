describe TimeEntryPolicy do
  subject { described_class }

  permissions :index? do
    context 'when the user is not an admin_user' do
      let(:user)       { create(:user) }
      let(:time_entry) { create(:time_entry) }

      it 'denies access' do
        expect(subject).not_to permit(user, time_entry)
      end
    end

    context 'when the user is an admin_user' do
      let(:user)       { create(:user, :admin_user) }
      let(:time_entry) { create(:time_entry) }

      it 'allow access' do
        expect(subject).to permit(user, time_entry)
      end
    end
  end

  permissions :create? do
    context 'when the user is not an admin_user' do
      let(:user)       { create(:user) }
      let(:time_entry) { create(:time_entry) }

      it 'denies access' do
        expect(subject).not_to permit(user, time_entry)
      end
    end

    context 'when the user is an admin_user' do
      let(:user)       { create(:user, :admin_user) }
      let(:time_entry) { create(:time_entry) }

      it 'allow access' do
        expect(subject).to permit(user, time_entry)
      end
    end
  end

  permissions :update? do
    context 'when the user is not an admin_user' do
      let(:user)       { create(:user) }
      let(:time_entry) { create(:time_entry) }

      it 'denies access' do
        expect(subject).not_to permit(user, time_entry)
      end
    end

    context 'when the user is a admin_user' do
      let(:user)       { create(:user, :admin_user) }
      let(:time_entry) { create(:time_entry) }

      it 'allow access even though it is not a user time entry' do
        expect(subject).to permit(user, time_entry)
      end
    end
  end

  permissions :destroy? do
    context 'when the user is not a admin_user' do
      let(:user)       { create(:user) }
      let(:time_entry) { create(:time_entry) }

      it 'denies access' do
        expect(subject).not_to permit(user, time_entry)
      end
    end

    context 'when the user is a admin_user' do
      let(:user)  { create(:user, :admin_user) }
      let(:user2) { create(:user) }

      it 'allow access' do
        expect(subject).to permit(user, user2)
      end
    end
  end
end
