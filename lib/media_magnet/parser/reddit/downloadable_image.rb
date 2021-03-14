module MediaMagnet
  module Parser
    class Reddit
      class DownloadableImage < MediaMagnet::Parser::Reddit::Image
        include MediaMagnet::Base::Downloadable

        def initialize(data:, opts: {})
          super
          @url = url
          @dir = opts[:dir]
          @local_name = filename
          # @no_sleep = true unless @sleep_time
          @sleep_time = opts[:sleep_time]
        end
      end 
    end 
  end 
end
