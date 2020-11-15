RSpec.describe MediaMagnet::Processor::Reddit do

  let(:subreddits) { ["VillagePorn"] }
  let(:opts) { { max_results: 2, path: path } }
  let(:path) { nil }
  let(:response) {
    File.open("spec/support/responses/reddit/processor/valid.html").read
  }

  before do
    stub_request(:get, "https://www.reddit.com/r/VillagePorn.json?limit=2")
      .to_return(status: 200, body: response)
  end

  subject {
    described_class.new(subreddits: subreddits, downloading: false, opts: opts)
  }

  describe "::call" do
    it "returns images posted the subreddit" do
      expect(subject.call.length).to eq(3)
    end
  end

  describe "when requesting a non-existant subreddit" do
    let(:subreddits) { ["0"] }

    before do
      stub_request(:get, "https://www.reddit.com/r/0.json?limit=2")
        .to_return(status: 404, body: {message: "Not Found", error: 404}.to_json)
    end

    describe "::call" do
      it "Raises an error" do
        expect {subject.call.length }.to raise_error(RuntimeError)
      end
    end
  end

  describe "when allowing net requests" do

    # TODO: Stub
    before do
      `mkdir #{path}`
      WebMock.disable!
    end

    after do
      `rm -r #{path}`
      WebMock.enable!
    end

    let(:path) {
      "#{described_class::DEFAULT_DOWNLOAD_PATH}/media_magnet"
    }

    subject {
      described_class.new(subreddits: subreddits, downloading: true, opts: opts)
    }

    describe "::call" do
      it "returns images posted the subreddit" do
        expect(subject.call.length).to be > 0
      end
    end
  end
end
