
module MediaMagnet
  module Recommender
    class TasteDive
      BASE_URL = "https://tastedive.com/api/similar?q="

      def initialize(queries)
        @querystring = URI.encode_www_form_component queries.join(",")
      end

      def url
        "#{BASE_URL}#{@querystring}"
      end

      def recommend
        contents = URI.open(url, "User-Agent" => UserAgent.random)
        json = JSON.parse(contents.read)
        json["Similar"]["Results"].map { |r| r["Name"] }
      end
    end 
  end
end