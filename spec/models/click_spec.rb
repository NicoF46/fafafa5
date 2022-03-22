# frozen_string_literal: true

require 'rails_helper'
require 'shoulda/matchers'
RSpec.describe Click, type: :model do
  describe 'validations' do
    it 'validates url_id is valid' do
      expect(Click.create(url_id: nil)).not_to be_valid
    end

    it 'validates browser is not null' do
      is_expected.to validate_presence_of(:browser)
    end

    it 'validates platform is not null' do
      is_expected.to validate_presence_of(:platform)
    end
  end
end
