RSpec.describe 'Users API', type: :request do
  describe 'POST /signup' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/signup', params: { name: 'bob', email: 'bob@example.com', password: '' }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'invalid parameters' do
      it 'returns an error' do
        post '/signup', params: { name: 'b.o.b', email: 'bob@example.com', password: 'givemeatoken' }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Укажите имя, используя буквы, цифры или символ подчёркивания',
            'source' => {
              'pointer' => '/data/attributes/name'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      it 'returns created status' do
        post '/signup', params: { name: 'bob', email: 'bob@example.com', password: 'givemeatoken' }

        expect(response).to have_http_status(:created)
      end
    end
  end
end
