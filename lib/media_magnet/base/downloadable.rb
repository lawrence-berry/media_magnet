require "open-uri"

module MediaMagnet
  module Base
    module Downloadable
      DEFAULT_DOWNLOAD_DIR = "/tmp/downloads"

      def download
        setup
        puts "Downloading #{@url} ... to #{path}"
        write
      end

      def path
        "#{@dir}/#{@local_name}"
      end

      private

      # TODO: Mutating ivars
      def setup
        @url = URI.parse(@url.chomp("/"))
        fail(ArgumentError, "Invalid url") unless
          ["URI::HTTP", "URI::HTTPS"].include?(@url.class.to_s)
        @dir ||= DEFAULT_DOWNLOAD_DIR
        Dir.mkdir(@dir) unless Dir.exist?(@dir)
        @local_name = @local_name || remote_name || tempoary_filename
      end

      def tempoary_filename
        Dir::Tmpname.create(["download-"], @dir) {}.split("/").last
      end

      def write
        open(path, "wb") do |f|
          f << URI.open(@url, "User-Agent" => UserAgent.random).read
        end
      end

      def remote_name
        return nil unless @url.path.length > 0
        @url.to_s.split("/").last.split("?").first
      end
    end
  end
end
