module MediaMagnet
  module Parser
    class Reddit
      class Image

        def initialize(data: , opts: {})
          @data = data
        end

        def to_h
          h = {
            name: filename,
            url: url
          }
          h[:youtube_id] = youtube_id if youtube_id
          h
        end

        def valid?
          !@data.dig("media_metadata").nil? || !@data.dig("preview").nil?
        end

        private

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
          sanitize_filename(@data["title"])
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
