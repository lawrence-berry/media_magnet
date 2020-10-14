RSpec.describe MediaMagnet::Recommender::TasteDive do

  let!(:queries) { ["Bassnectar"] }
  let(:response) {
    File.open("spec/support/responses/recommender/taste_dive.json").read
  }

  before do
    stub_request(:get, "https://tastedive.com/api/similar?q=#{queries[0]}")
      .to_return(status: 200, body: response)
  end

  subject {
    described_class.new(queries).recommend
  }

  describe "::call" do
    it "returns similar artists" do
      expect(subject.length).to eq(20)
    end
  end

  describe "when requesting a non-existant artist" do
    let!(:queries) { ["0"] }
    let(:response) {
      {
        "Similar": {
          "Info": [{
            "Name": "0",
            "Type": "unknown"
          }, {
            "Name": "0",
            "Type": "unknown"
          }],
          "Results": []
        }
      }.to_json
    }

    describe "::call" do
      it "returns an empty array" do
        expect(subject.length).to be_zero
      end
    end
  end
end