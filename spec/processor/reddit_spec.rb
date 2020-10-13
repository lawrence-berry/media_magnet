RSpec.describe MediaMagnet::Processor::Reddit do

  let(:subreddits) { ["VillagePorn"] }
  let(:response) {
    File.open("spec/support/responses/reddit/processor/valid.html").read
  }
  
  before do
    stub_request(:get, "https://www.reddit.com/r/VillagePorn/top.json?limit=20")
      .to_return(status: 200, body: response, headers: {})
  end

  subject {
    described_class.new(subreddits)
  }

  describe "::call" do
    it "returns images posted the subreddit" do
      expect(subject.call.length).to eq(3)
    end
  end
end
