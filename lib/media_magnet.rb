require "media_magnet/version"
require "media_magnet/base/user_agent"
require "media_magnet/base/downloadable"
require "media_magnet/base/artist_extractor"
require "media_magnet/mediums/youtube_url"

require "media_magnet/recommender/taste_dive"

require "media_magnet/processor/reddit"
require "media_magnet/collections/reddit"
require "media_magnet/parser/reddit/image"
require "media_magnet/parser/reddit/youtube_id"
require "media_magnet/parser/reddit/downloadable_image"

require "pry"

module MediaMagnet
  class Error < StandardError; end
  # Your code goes here...
end
