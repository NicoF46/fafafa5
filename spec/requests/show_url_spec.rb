require 'rails_helper'

RSpec.describe 'shows the url stats', type: :request do
  let(:params) { { url: 'http://example.com' } }

  subject { get '/urls/2'}
  let(:url) { double(:url, original_url: 'https:://www.google.com') }

  context 'when the request success in fetching the stats' do
    let(:url) do
      double(:url, short_url: 'FAFA',
                   created_at: Time.zone.now, original_url: 'http://example.com')
    end
    let(:daily_clicks) do
      double(:daily_clicks)
    end
    let(:browsers_clicks) do
      double(:browsers_clicks)
    end
    let(:platform_clicks) do
      double(:platform_clicks)
    end

    before do
      allow(ShowUrlStats).to receive(:call).and_return(double(:result,
                                                              failure?: false,
                                                              url: url,
                                                              stats: {
                                                                daily_clicks: daily_clicks,
                                                                browsers_clicks: browsers_clicks,
                                                                platform_clicks: platform_clicks
                                                              }))
      subject
    end

    it { expect(response).to render_template :show }
    it { expect(response).to have_http_status(:ok) }

    it 'assigns the stats from the interactor' do
      expect(assigns(:url)).to eq(url)
      expect(assigns(:daily_clicks)).to eq(daily_clicks)
      expect(assigns(:browsers_clicks)).to eq(browsers_clicks)
      expect(assigns(:platform_clicks)).to eq(platform_clicks)
    end
  end
end
