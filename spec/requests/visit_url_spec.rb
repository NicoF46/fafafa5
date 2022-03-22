require 'rails_helper'

RSpec.describe 'Visit the original url', type: :request do
  let(:original_url) { 'https:://www.google.com' }
  let(:url) { double(:url, original_url: original_url) }

  before do
    allow(VisitUrl).to receive(:call).and_return(double(:result, failure?: false, url: url))
    get '/ABCDE'
  end

  it { expect(response).to redirect_to original_url }

  it { expect(response).to(have_http_status(:found)) }
end
