class Encoder
  ENCODER_SYMBOLS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.freeze
  ENCODER_BASE = ENCODER_SYMBOLS.size

  def self.encode(url)
    short_url = []
    while url.positive?
      short_url << ENCODER_SYMBOLS[url % ENCODER_BASE]
      url /= ENCODER_BASE
    end

    short_url.reverse.join
  end

  def self.decode(short_url)
    url_id = 0
    short_url.reverse.chars.each.with_index do |d, i|
      url_id += ENCODER_SYMBOLS.index(d) * (ENCODER_BASE**i)
    end
    url_id
  end
end
