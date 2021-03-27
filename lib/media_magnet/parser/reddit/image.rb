module MediaMagnet
  module Parser
    class Reddit
      class Image

        VALID_EXTENSIONS = ["jpg", "jpeg", "png"]

        def initialize(data:, opts: {})
          @data = data
        end

        def to_h
          { name: filename, url: url }
        end

        def valid?
          !@data["url"].match(/\/comments\//) &&
            VALID_EXTENSIONS.include?(extension)
        end

        private

        # why is this needed on an image?
        def youtube_id
          MediaMagnet::Mediums::YoutubeUrl.new(url, "", "").youtube_id
        end

        def url
          URI.decode(@data["url"])
        end

        def remote_name
          url.split("/").last.split("?").first
        end

        def extension
          url.split(".").last.split("?").first
        end

        def filename
          sanitize_filename("#{@data['title']}_by_#{@data['author']}")
        end

        def sanitize_filename(raw_filename)
          raw_filename
            .gsub(%r{^.*(\\|/)}, "")
            .gsub(/\.|\||\(|\)|\,|\.|\,|\[|\]/, "")
            .gsub(/[^0-9A-Za-z.\-]/, "_")
            .tr("_", " ")
            .strip
        end
      end
    end
  end
end
