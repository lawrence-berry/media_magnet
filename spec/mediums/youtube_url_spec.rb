require "spec_helper"

RSpec.describe MediaMagnet::Mediums::YoutubeUrl do
  let(:url) { "https://www.youtube.com/watch?v=uXVhpfWKS_U" }

  let(:dir) { "/tmp" }
  let(:filename) { "abpo" }

  subject { described_class.new(url, dir, filename) }

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