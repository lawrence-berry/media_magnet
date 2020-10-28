
module MediaMagnet
  module Mediums
    class YoutubeUrl
      # include MediaMagnet::Base::Downloadable
      
      def initialize(url, dir, filename)
        @url = URI.decode(url)
        @dir = dir
        @local_name = filename
      end

      def fetch
        return if invalid?
        {
          name: name,
          url: url,
          youtube_id: youtube_id,
          # path: download.path
        }
      end

      def invalid?
        !valid_url? || previous_download
      end
      
      def name
        @local_name
      end
      
      def youtube_id
        return unless @url.match(/.*\/youtu\.be|youtube\.com\/(.*)$/)
        match = @url.match(/.*watch\?v=(.*)$/)
        if match && match.length > 0
          return match[1].split("&")[0]
        end
        match = @url.match(/.*\/youtu\.be|youtube\.com\/(.*)$/)
        if match && match.length > 0
          @url.split("/").last.split("&")[0]
        end
      end

      private

      def previous_download?
        File.exist?(@path) || File.exist?(error_path) || pre_existing_file?
      end

      def pre_existing_file?
        Dir.glob("#{@dir}*#{@local_name}").any?
      end

      def error_path
        "#{ENV['HOME']}/Pictures/Wallpaper/bin/rejected/#{local_name}"
      end

      def valid_url?
        @url.match(/^(https\:\/\/)?(www.)?(youtube\.com|youtu\.be).*$/)
      end
    end 
  end 
end


