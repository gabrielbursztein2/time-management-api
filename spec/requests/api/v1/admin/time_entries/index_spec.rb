describe 'GET api/v1/time_entries', type: :request do
  let(:yesterday)    { Time.zone.yesterday }
  let(:today)        { Time.zone.today }
  let!(:time_entry1) { create(:time_entry, date: yesterday) }
  let!(:time_entry2) { create(:time_entry, date: today) }

  subject do
    get api_v1_admin_time_entries_path, headers: auth_headers, as: :json
  end

  context 'when the user has permissions' do
    let(:user) { create(:user, :admin_user) }

    it 'returns all the time_entries' do
      subject
      expect(json[:time_entries].count).to eq(2)
    end

    it 'returns the time_entries ordered by date' do
      subject
      expect(json[:time_entries][0][:id]).to eq(time_entry2.id)
      expect(json[:time_entries][1][:id]).to eq(time_entry1.id)
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
