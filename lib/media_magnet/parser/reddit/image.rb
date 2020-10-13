module MediaMagnet
  module Parser
    class Reddit
      class Image

        def initialize(data)
          @data = data
        end

        def to_h
          { name: filename, url: url }
        end

        def valid?
          !@data.dig("media_metadata").nil? || !@data.dig("preview").nil?
        end

        private

        def url
          @data["url"]
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
