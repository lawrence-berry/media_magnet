require "open-uri"
require "pry"

module MediaMagnet
  module Base
    module Downloadable
      DEFAULT_DOWNLOAD_DIR = "/tmp/downloads"

      def download
        configure
        puts "Downloading #{@url} ... to #{path}"
        write
        rate_limit
        @output
      end

      def path
        "#{@dir}/#{@local_name}"
      end

      private

      # TODO: Mutating ivars
      def configure
        @url = URI.parse(@url.chomp("/"))
        fail(ArgumentError, "Invalid url") unless
          ["URI::HTTP", "URI::HTTPS"].include?(@url.class.to_s)
        @dir ||= DEFAULT_DOWNLOAD_DIR
        Dir.mkdir(@dir) unless Dir.exist?(@dir)
        @local_name = local_name_with_ext || remote_name || tempoary_filename
      end

      def local_name_with_ext
        return unless @local_name
        "#{@local_name[0..254]}.#{remote_extension}"
      end

      def remote_extension
        remote_name.split(".").last
      end

      def rate_limit
        return if @no_sleep
        fail "No @sleep_time specified" unless @sleep_time
        sleep @sleep_time
      end

      def tempoary_filename
        Dir::Tmpname.create(["download-"], @dir) {}.split("/").last
      end

      def write
        puts("Skipping, #{path} exists") and return if File.exist?(path)
        @output = open(path, "wb") do |f|
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
