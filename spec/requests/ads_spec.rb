RSpec.describe 'Ads API', type: :request do
  describe 'GET /' do
    let(:user) { create(:user) }

    before do
      create_list(:ad, 3, user: user)
    end

    it 'returns a collection of ads' do
      get '/'

      expect(response).to have_http_status(:success)
      expect(response_body['data'].size).to eq(3)
    end
  end

  describe 'POST /ads (valid auth token)' do
    let(:user) { create(:user) }

    context 'missing parameters' do
      it 'returns an error' do
        post '/ads', headers: auth_headers(user)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'invalid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: ''
        }
      end

      it 'returns an error' do
        post '/ads', headers: auth_headers(user), params: { ad: ad_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Укажите город',
            'source' => {
              'pointer' => '/data/attributes/city'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      let(:last_ad) { user.ads.last }

      it 'creates a new ad' do
        expect { post '/ads', headers: auth_headers(user), params: { ad: ad_params } }
          .to change { user.ads.count }.from(0).to(1)

        expect(response).to have_http_status(:created)
      end

      it 'returns an ad' do
        post '/ads', headers: auth_headers(user), params: { ad: ad_params }

        expect(response_body['data']).to a_hash_including(
          'id' => last_ad.id.to_s,
          'type' => 'ad'
        )
      end
    end
  end

  describe 'POST /ads (invalid auth token)' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: 'City'
      }
    end

    it 'returns an error' do
      post '/ads', params: { ad: ad_params }

      expect(response).to have_http_status(:forbidden)
      expect(response_body['errors']).to include('detail' => 'Доступ к ресурсу ограничен')
    end
  end
end
