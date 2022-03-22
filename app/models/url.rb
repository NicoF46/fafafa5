# frozen_string_literal: true

class Url < ApplicationRecord
  scope :latest, -> { limit(10).order(created_at: :desc) }

  has_many :clicks

  after_create :create_short_url

  validates :original_url, presence: true,
                           format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }

  validates :short_url, uniqueness: true, presence: true, format: { with: /[^A-Z]*/ }

  def perform_click(browser_name, platform_name)
    Click.create!(browser: browser_name, platform: platform_name, url_id: id)
    update(clicks_count: clicks_count + 1)
  end

  def statistics
    {
      short_url: short_url,
      daily_clicks: daily_clicks,
      browsers_clicks: browsers_clicks,
      platform_clicks: platform_clicks
    }
  end

  private

  def create_short_url
    update(short_url: Encoder.encode(id))
  end

  def daily_clicks
    result = clicks.current_month.group_by { |t| t.created_at.day }
    result.map { |k, v| [k.to_s, v.length] }
  end

  def browsers_clicks
    clicks.group(:browser).count.to_a
  end

  def platform_clicks
    clicks.group(:platform).count.to_a
  end
end
