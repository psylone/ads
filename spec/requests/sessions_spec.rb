RSpec.describe 'Sessions API', type: :request do
  describe 'POST /login' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/login', params: { email: 'bob@example.com', password: '' }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'invalid parameters' do
      it 'returns an error' do
        post '/login', params: { email: 'bob@example.com', password: 'invalid' }

        expect(response).to have_http_status(:unauthorized)
        expect(response_body['errors']).to include('detail' => 'Сессия не может быть создана')
      end
    end

    context 'valid parameters' do
      let(:token) { 'jwt_token' }

      before do
        create(:user, email: 'bob@example.com', password: 'givemeatoken')

        allow(JWT).to receive(:encode).and_return(token)
      end

      it 'returns created status' do
        post '/login', params: { email: 'bob@example.com', password: 'givemeatoken' }

        expect(response).to have_http_status(:created)
        expect(response_body['meta']).to eq('token' => token)
      end
    end
  end
end
