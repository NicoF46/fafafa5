module Api
  class UrlsController < ApplicationController
    def index
      @url_list = Url.latest
      render json: formated_response
    end

    private

    def formated_response
      {
        data: map_urls_json
      }
    end

    def map_urls_json
      urls = []
      @url_list.each do |url|
        urls << map_url_json(url)
      end
      urls
    end

    def map_url_json(url)
      { type: 'url',
        id: url.id,
        attributes: {
          created_at: url.created_at,
          original_url: url.created_at,
          url: url.short_url,
          clicks: url.clicks_count
        },
        relationships: {
          clicks: url.clicks
        } }
    end
  end
end
