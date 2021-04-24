# Example Usage

```

r = MediaMagnet::Processor::Reddit.new(subreddits: ["Wallpaper"]).call

r = MediaMagnet::Processor::Reddit.new(subreddits: ["idm"]).call
a = MediaMagnet::Base::ArtistExtractor.extract_all(titles: r)
results = MediaMagnet::Recommender::TasteDive.new(a).recommend
```
