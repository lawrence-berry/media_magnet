RSpec.describe MediaMagnet::Base::Downloadable do
  before do
    WebMock.disable!
  end

  after do
    WebMock.enable!
  end

  class TestClass
    include MediaMagnet::Base::Downloadable

    def initialize(url:, dir: nil, local_name: nil)
      @url = url
      @dir = dir
      @local_name = local_name
    end
  end

  let(:params) { { url: url } }
  let(:url) { "https://i.redd.it/ojab1ipycps51.jpg" }

  subject {
    TestClass.new(**params)
  }

  describe "given an invalid url" do
    let(:url) { "notaurl.jpg" }

    it "raises an error" do
      expect { TestClass.new(url: url).download.path }.to raise_error(ArgumentError)
    end
  end

  describe "given a local filename" do
    let(:dir) { "/tmp/needstoexist" }
    let(:params) {
      {
        url: url,
        dir: dir
      }
    }

    it "downloads a file to the filename provided" do
      @downloaded_path = subject.download.path
      expect(File.exist?(@downloaded_path)).to be(true)
      expect(/.*#{dir}.*/).to match(@downloaded_path)
      `rm -r #{@dir}`
    end
  end

  describe "with a valid url" do
    after do
      `rm #{@downloaded_path}`
    end

    describe "given a downlaodable url" do
      it "downloads a file" do
        @downloaded_path = subject.download.path
        expect(File.exist?(@downloaded_path)).to be(true)
      end
    end

    describe "given a local filename" do
      let(:local_name) { "local.jpg" }
      let(:params) {
        {
          url: url,
          local_name: local_name
        }
      }

      it "downloads a file to the filename provided" do
        @downloaded_path = subject.download.path
        expect(File.exist?(@downloaded_path)).to be(true)
        expect(/.*#{local_name}.*/).to match(@downloaded_path)
      end
    end

    describe "when the url has no filename" do
      let(:url) { "https://www.google.com/" }

      it "downloads a file using a tempoary filename" do
        @downloaded_path = subject.download.path
        expect(File.exist?(@downloaded_path)).to be(true)
        expect(/.*download-.*/).to match(@downloaded_path)
      end
    end
  end
end
