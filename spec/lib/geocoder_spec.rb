RSpec.describe Geocoder do
  subject { described_class }

  before { stub_const("#{described_class}::DATA_PATH", "#{fixture_path}/city.csv") }

  describe '.geocode' do
    context 'existing city' do
      it 'returns coordinates' do
        result = subject.geocode('City 17')

        expect(result).to eq([45.05, 90.05])
      end
    end

    context 'missing city' do
      it 'returns a nil value' do
        result = subject.geocode('Missing')

        expect(result).to be_nil
      end
    end
  end
end
