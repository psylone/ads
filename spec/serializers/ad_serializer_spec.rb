RSpec.describe AdSerializer do
  subject { described_class.new([ad], links: links) }

  let(:ad) { create(:ad) }

  let(:links) do
    {
      first: '/path/to/first/page',
      last: '/path/to/last/page',
      next: '/path/to/next/page'
    }
  end

  let(:attributes) do
    ad.slice(
      :title,
      :description,
      :city,
      :lat,
      :lon
    ).symbolize_keys
  end

  it 'returns ad representation' do
    expect(subject.serializable_hash).to a_hash_including(
      data: [
        {
          id: ad.id.to_s,
          type: :ad,
          attributes: attributes
        }
      ],
      links: links
    )
  end
end
