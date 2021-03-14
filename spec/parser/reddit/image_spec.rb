RSpec.describe MediaMagnet::Parser::Reddit::Image do

  let(:data) {
    JSON.parse(
      File.open("spec/support/responses/reddit/image/valid.json").read
    )["data"]
  }

  let(:path) {
    "#{ENV['HOME']}/Pictures/Wallpaper/images/2020/" \
    "5_reddit_lockdown/"
  }

  subject {
    described_class.new(data: data, opts: { dir: path })
  }

  describe "::to_h" do
    it "returns images posted the subreddit" do
      expect(subject.to_h).to eq(
        {
          name: "Gordes Vaucluse France 2592x3872 by loulan",
          url: "https://live.staticflickr.com/65535/49750484603_29292a00ab_o.jpg"
        }
      )
    end
  end
end
