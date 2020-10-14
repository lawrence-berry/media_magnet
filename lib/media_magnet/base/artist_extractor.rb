module MediaMagnet
  module Base
    class ArtistExtractor

      def self.extract_all(titles:)
        titles.map { |title| new(title: title[:name]).artist }.compact
      end

      def initialize(title:)
        @title = title
      end

      def artist
        return unless @title.include?("-")
        @title.split("-")[0].strip
      end
    end
  end
end
