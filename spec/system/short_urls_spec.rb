# frozen_string_literal: true

require 'rails_helper'
require 'webdrivers'

# WebDrivers Gem
# https://github.com/titusfortner/webdrivers
#
# Official Guides about System Testing
# https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html

RSpec.describe 'Short Urls', type: :system do
  before do
    driven_by :selenium, using: :chrome
    # If using Firefox
    # driven_by :selenium, using: :firefox
    #
    # If running on a virtual machine or similar that does not have a UI, use
    # a headless driver
    # driven_by :selenium, using: :headless_chrome
    # driven_by :selenium, using: :headless_firefox
  end

  describe 'index' do
    before do
      visit root_path
    end

    it 'shows a list of short urls' do
      expect(page).to have_text('HeyURL!')
    end

    context 'when there are more than 10 urls' do
      let!(:urls_list) { create_list(:url, 15) }

      it 'shows only 10' do
        visit root_path
        expect(page.text.scan(/127.0.0.1/).length).to eq(10)
      end
    end

    context 'when there are less than 10 urls' do
      let!(:urls_list) { create_list(:url, 5) }

      it 'shows all the urls' do
        visit root_path
        expect(page.text.scan(/127.0.0.1/).length).to eq(5)
      end
    end
  end

  describe 'show' do
    let(:url_route) { 'https:://www.google.com' }
    let(:url) { Url.create(original_url: url_route, short_url: 'ABCDE') }

    it 'shows a panel of stats for a given short url' do
      visit url_path(url.short_url)
      expect(page).to have_text('Stats')
    end

    it 'shows a panel of stats for a given short url' do
      visit url_path(url.short_url)
      expect(page).to have_text(url_route)
    end

    context 'when not found' do
      it 'shows a 404 page' do
        visit url_path('NOTFOUND')
        expect(page).to have_text('Failed to visit the url')
      end
    end
  end

  describe 'create' do
    context 'when url is valid' do
      let(:url_route) { 'https:://www.google.com' }

      before do
        visit '/'
        fill_in 'Your original URL here', with: url_route
        click_button('Shorten URL')
      end

      it 'creates the short url' do
        expect(page).to have_text('shorten created succesfully')
      end

      it 'redirects to the home page' do
        expect(page).to have_current_path('/urls')
      end
    end

    context 'when url is invalid' do
      let(:url_route) { 'Invalid_url' }

      before do
        visit '/'
        fill_in 'Your original URL here', with: url_route
        click_button('Shorten URL')
      end

      it 'does not create the short url and shows a message' do
        expect(page).to have_text('Failed to create the URL')
      end

      it 'redirects to the home page' do
        expect(page).to have_current_path('/urls')
      end
    end
  end

  describe 'visit' do
    let(:url_route) { 'https:://www.google.com' }
    let!(:url) { Url.create(original_url: url_route, short_url: 'ABCDE') }

    context 'when the url exists' do
      it 'redirects to short url' do
        visit visit_path('ABCDE')
        assert_current_path '/ABCDE'
      end
    end

    context 'when not found' do
      it 'shows a 404 page' do
        visit visit_path('NOTFOUND')
        expect(page).to have_text('URL Not found')
      end
    end
  end
end
