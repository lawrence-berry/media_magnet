require "media_magnet/version"
require "media_magnet/base/user_agent"
require "media_magnet/base/downloadable"
require "media_magnet/mediums/youtube_url"

require "media_magnet/processor/reddit"
require "media_magnet/parser/reddit/image"
require "media_magnet/parser/reddit/downloadable_image"

module MediaMagnet
  class Error < StandardError; end
  # Your code goes here...
end
