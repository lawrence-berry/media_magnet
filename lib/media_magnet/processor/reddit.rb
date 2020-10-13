require "open-uri"
require "nokogiri"
require "json"

module MediaMagnet
  module Processor
    class Reddit
      DOWNLOAD_PATH = "#{ENV['HOME']}/Pictures/Wallpaper/images/2020/" \
      "5_reddit_lockdown/"
      BASE_URL = "https://www.reddit.com/r/"
      MAX_RESULTS = 20

      def initialize(subreddits)
        @subreddits = subreddits
        @targets ||= @subreddits.map do |t|
          { 
            folder: "#{DOWNLOAD_PATH}#{t}",
            url: "#{BASE_URL}#{t}/top.json?limit=#{MAX_RESULTS}"
          }
        end
      end

      def call
        prepare_folders
        # result = @targets.map { |s| process(s[:url], s[:folder]) }
        process
        @results[0]
      end

      # private 

      # TODO: Error handling, optional downloading, sleeps
      def process
        @results = @targets.map do |target|
          doc = doc_from target[:url]
          JSON.parse(doc)["data"]["children"].map do |c|
            result = MediaMagnet::Parser::Reddit::Image.new(c["data"])
            next unless result.valid?
            result.to_h
          end.compact.reject { |r| r[:url].nil? }
        end
      end

      def doc_from(url)
        @doc ||= Nokogiri::HTML(URI.open(url, "User-Agent" => UserAgent.random))
      end

      # TODO: Move to downloadable?
      def prepare_folders
        fail "#{DOWNLOAD_PATH} does not exist" unless File.directory?(DOWNLOAD_PATH)
        @targets.map do |url|
          `mkdir -p #{url[:folder]}` unless File.directory?(url[:folder])
        end
      end
    end 
  end 
end