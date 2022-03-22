require 'rails_helper'

RSpec.describe 'Create short url request', type: :request do
  let(:params) { { url: { original_url: 'https://www.google.com' } } }
  subject { post '/urls', params: params }

  before do
    allow(CreateUrl).to receive(:call).and_return(double(:result, failure?: false))
  end

  it 'should call the create url interactor with the original url' do
    expect(CreateUrl).to receive(:call).with({ 'original_url' => 'https://www.google.com' })
    subject
  end

  context 'when success creating the new url' do
    before do
      allow(CreateUrl).to receive(:call).and_return(double(:result, failure?: false))
      subject
    end

    it { expect(response).to redirect_to urls_path }
  end
end
