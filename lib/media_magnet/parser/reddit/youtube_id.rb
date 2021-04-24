module MediaMagnet
  module Parser
    class Reddit
      class YoutubeId

        def initialize(url)
          @url = url
        end

        def id
          match = @url.match(/.*watch\?v=(.*)$/)
          if match && match.length > 0
            return match[1].split("&")[0]
          end
          uri = URI.parse(@url)
          match = uri.host == "youtu.be" && uri.path.gsub("/", "")
          if match && match.length > 0
            return match.split("&")[0]
          end
          match = @url.match(/.*\/youtu\.be|youtube\.com\/(.*)$/)
          if match && match.length > 0
            match[1].split("/").last.split("&")[0]
          end
        end
      end
    end
  end
end
