require 'rails_helper'
require './lib/encoder'

RSpec.describe Encoder do
  describe '#encode' do
    it 'should encode the id to the short url base' do
      expect(Encoder.encode(1_235_663)).to eq('CSHXN')
    end
  end

  describe '#decode' do
    it 'should decode the encoded url to the correct id' do
      expect(Encoder.decode('CSHXN')).to eq(1_235_663)
    end
  end
end
