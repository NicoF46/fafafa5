require 'rails_helper'

describe Api::UrlsController, type: :controller do
  describe '#index' do
    context 'when we have urls in the db' do
      let!(:urls_list) { create_list(:url, 5) }

      before do
        get :index
      end

      it 'should return a json' do
        expect(response.content_type).to include('application/json')
      end

  #    it 'should return the correct urls' do
  #      expect(response.body.to_h_keys).to include['data']
  #    end

      it 'should return the correct status' do
        expect(response.status).to eq(200)
      end
    end
  end
end
