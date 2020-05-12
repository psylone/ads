require 'rails_helper'

RSpec.describe Ads::GeocodingJob, type: :job do
  subject { described_class }

  let(:ad) { create(:ad, city: 'City 17') }

  context 'existing city' do
    let(:lat) { 45.05 }
    let(:lon) { 90.05 }

    before do
      allow(Geocoder).to receive(:geocode)
        .with('City 17')
        .and_return([lat, lon])
    end

    it 'updates ad coordinates' do
      subject.perform_now(ad)

      expect(ad.lat).to eq(lat)
      expect(ad.lon).to eq(lon)
    end
  end

  context 'missing city' do
    before do
      allow(Geocoder).to receive(:geocode)
        .with('City 17')
        .and_return(nil)
    end

    it 'does not update ad coordinates' do
      subject.perform_now(ad)

      expect(ad.lat).to be_nil
      expect(ad.lon).to be_nil
    end
  end
end
