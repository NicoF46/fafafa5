# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it 'validates original URL is a valid URL' do
      should_not allow_value('1bcd').for(:original_url)
    end

    it 'validates short URL is present' do
      is_expected.to validate_presence_of(:short_url)
    end

    describe '#perform_click' do
      let!(:url) { create(:url) }

      it 'creates a click' do
        expect { url.perform_click('Chrome', 'Linux') }.to change { Click.count }.by(1)
      end

      it 'updates the click counter' do
        expect { url.perform_click('Chrome', 'Linux') }.to change { url.clicks_count }.by(1)
      end
    end

    def statistics
      let!(:url) { create(:url) }
      let(:platform) { 'Linux' }
      let(:browser) { 'Chrome' }
      let(:click) { url.perform_click(browser, platform) }

      it 'returns the correct short url' do
        expect(url.statistics[:short_url]).to eq(url.short_url)
      end

      it 'returns the correct daily clicks' do
        expect(url.statistics[:daily_clicks]).to eq([Time.zone.now.day, '1'])
      end

      it 'returns the correct browser clicks' do
        expect(url.statistics[:daily_clicks]).to eq([browser, '1'])
      end

      it 'returns the correct platform clicks' do
        expect(url.statistics[:daily_clicks]).to eq([platform, '1'])
      end
    end
  end
end
