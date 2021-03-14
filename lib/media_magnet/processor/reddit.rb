require "open-uri"
require "nokogiri"
require "json"

module MediaMagnet
  module Processor
    class Reddit
      DEFAULT_DOWNLOAD_PATH = MediaMagnet::Base::Downloadable::DEFAULT_DOWNLOAD_DIR
      BASE_URL = "https://www.reddit.com/r/"
      SLEEP_TIME = 0.1
      MAX_RESULTS = 20

      def initialize(subreddits:, downloading: false, opts: {})
        @downloading, @subreddits, @opts = downloading, subreddits, opts
        @targets ||= @subreddits.map do |t|
          {
            folder: "#{download_path}#{t}",
            url: "#{BASE_URL}#{t}.json?limit=#{max_results}"
          }
        end
      end

      def call
        prepare_folders
        process
        @results[0]
      end

      private 

      def max_results
        @opts[:max_results] || MAX_RESULTS 
      end

      def download_path
        @opts[:path] || DEFAULT_DOWNLOAD_PATH
      end

      def process
        @results = @targets.map do |target|
          doc = doc_from target[:url]
          JSON.parse(doc)["data"]["children"].map do |c|
            result = parser(c)
            next unless result.valid?
            result.download if @downloading
            result.to_h
          end.compact.reject { |r| r[:url].nil? }
        end
      end

      def parser(c)
        ut = MediaMagnet::Mediums::YoutubeUrl.new(c["data"]["url"], nil, c["data"]["title"])
        return ut if ut.valid?
        if @downloading
          MediaMagnet::Parser::Reddit::DownloadableImage
            .new(data: c["data"], opts: {dir: download_path, sleep_time: SLEEP_TIME})
        else
          MediaMagnet::Parser::Reddit::Image.new(data: c["data"])
        end
      end

      def doc_from(url)
        contents = URI.open(url, "User-Agent" => UserAgent.random)
        @doc ||= Nokogiri::HTML(contents)
      rescue StandardError
        fail "Could not fetch subreddit via #{url}"
      end

      def prepare_folders
        return unless @downloading
        fail "#{download_path} does not exist" unless File.directory?(download_path)
        @targets.map do |url|
          `mkdir -p #{url[:folder]}` unless File.directory?(url[:folder])
        end
      end
    end 
  end 
end
