describe 'GET api/v1/time_entries', type: :request do
  let(:user)         { create(:user) }
  let(:yesterday)    { Time.zone.yesterday }
  let(:today)        { Time.zone.today }
  let!(:time_entry1) { create(:time_entry, user: user, date: yesterday) }
  let!(:time_entry2) { create(:time_entry, user: user, date: today) }

  subject { get api_v1_time_entries_path, headers: auth_headers, as: :json }

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
