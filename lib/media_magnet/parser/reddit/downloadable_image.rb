module MediaMagnet
  module Parser
    class Reddit
      class DownloadableImage < MediaMagnet::Parser::Reddit::Image
        include MediaMagnet::Base::Downloadable
        
        DEFAULT_SLEEP_TIME = 0.1

        def initialize(data:, opts: {})
          super
          @url = url
          @dir = opts[:dir]
          @local_name = filename
          @no_sleep = true and return if opts[:no_sleep]
          @sleep_time = opts[:sleep_time] || DEFAULT_SLEEP_TIME
        end
      end 
    end 
  end 
end
