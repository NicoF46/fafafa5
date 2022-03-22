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

    # add more tests
  end
end
