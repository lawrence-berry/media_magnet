RSpec.describe MediaMagnet::Base::ArtistExtractor do

  describe "::artist" do

    subject {
      described_class.new(title: title).artist
    }

    describe "given a - delimited title" do
      let(:title) { "artist - track" }

      it "returns the artist" do
        expect(subject).to eq("artist")
      end
    end

    describe "given a malformed title" do
      let(:title) { "artist track" }

      it "retuns nil" do
        expect(subject).to be(nil)
      end
    end
  end

  describe "::extract_all" do

    subject {
      described_class.extract_all(titles: titles)
    }

    describe "given - delimited titles" do
      let(:titles) {
        [
          { name: "artist - track" },
          { name: "another - title" }
        ]
      }

      it "returns all artists" do
        expect(subject).to eq(["artist", "another"])
      end
    end

    describe "given a malformed title" do
      let(:titles) {
        [
          { name: "artist - track" },
          { name: "another - title" },
          { name: "artist track" }
        ]
      }

      it "returns all artists that can be extracted" do
        expect(subject).to eq(["artist", "another"])
      end
    end
  end
end
