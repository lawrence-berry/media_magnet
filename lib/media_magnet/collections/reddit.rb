
module MediaMagnet
  module Collections
    module Reddit

      def self.wallpaper_subs
        %w{
          wallpaper futurePorn cyberpunk EarthPorn CityPorn
          SkyPorn BeachPorn WaterPorn SpacePorn
        }
      end

      def self.alt_wallpaper_subs
        %w{BotanicalPorn VillagePorn}
      end

      def self.music_subs
        %w{breakbeat dubstep idm dnb minimal futurebeats fidget}
      end

      # https://www.reddit.com/r/Music/wiki/musicsubreddits#wiki_electronic_music
      def self.alt_music_subs
        %w{
          turntablists cxd LiquidDubstep witch_house theOverload boogiemusic
          90srock 90salternative breakbeat happyhardcore trance dnb darkstep
          breakcore electrohouse house psytrance futurebeats
          gamemusic fidget electronicjazz
          jazznoir vaporwave shoegaze SilkySmoothMusic listentous outrun
          vintageobscura mathrock twinkledaddies theoverload woahtunes
          psybient trapmuzik electroswing PBRNB
        }
      end
    end 
  end 
end
