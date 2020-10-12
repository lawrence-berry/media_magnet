module UserAgent
  IDS = [
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 \
    (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2",
    "HTC Mozilla/5.0 (Linux; Android 7.0; HTC 10 Build/NRD90M) AppleWebKit/537.36 \
    (KHTML, like Gecko) Chrome/58.0.3029.83 Mobile Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) \
    Chrome/58.0.3029.110 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:53.0) Gecko/20100101 Firefox/53.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) \
    Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393"
  ].freeze

  def self.random
    UserAgent::IDS.sample
  end
end
