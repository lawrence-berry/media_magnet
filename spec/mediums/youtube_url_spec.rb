require "spec_helper"

RSpec.describe MediaMagnet::Mediums::YoutubeUrl do
  let(:url) { "https://www.youtube.com/watch?v=uXVhpfWKS_U" }
  let(:filename) { "abpo" }
  let(:data) {
    {
      "url" => url,
      "title" => filename,
      "thumbnail" => "athumbnail"
    }
  }

  subject { described_class.new(data, dir: nil) }

  it "extracts basic info" do
    expect(subject.to_h[:name]).to eq filename
    expect(subject.to_h[:url]).to eq url
    expect(subject.to_h[:thumbnail]).to eq "athumbnail"
  end

  describe "::youtube_id" do
    it "extracts IDs from long-form urls" do
      expect(subject.youtube_id).to eq "uXVhpfWKS_U"
    end

    describe "given a shortform url" do
      let(:url) { "https://youtu.be/2KJI_huiiEo" }

      it "extracts IDs from long-form urls" do
        expect(subject.youtube_id).to eq "2KJI_huiiEo"
      end
    end
  end
end
