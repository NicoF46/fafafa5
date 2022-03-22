# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :url

  scope :current_month, lambda {
                          where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
                        }

  validates :browser, presence: true
  validates :platform, presence: true
end
