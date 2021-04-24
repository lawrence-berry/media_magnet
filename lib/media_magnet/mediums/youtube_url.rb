module MediaMagnet
  module Mediums
    class YoutubeUrl
      
      attr_reader :url

      def initialize(data, dir: nil)
        @url = URI.decode(data["url"])
        @dir = dir
        @local_name = data["title"]
        @thumbnail =  data["thumbnail"]
      end

      def to_h
        return unless valid?
        {
          name: name,
          url: url,
          youtube_id: youtube_id,
          thumbnail: @thumbnail
        }
      end

      def valid?
        valid_url?  && youtube_id
      end

      def name
        @local_name
      end

      def youtube_id
        return unless valid_url?
        MediaMagnet::Parser::Reddit::YoutubeId.new(@url).id
      end

      private

      def valid_url?
        @url.match(%r{^(https://)?(www.)?(youtube\.com|youtu\.be).*$})
      end
    end
  end
end
