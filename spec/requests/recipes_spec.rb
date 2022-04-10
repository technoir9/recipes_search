# frozen_string_literal: true

RSpec.describe 'Recipes', type: :request do
  describe 'GET /index' do
    subject { get '/recipes/index' }

    it 'returns http success' do
      subject

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /search' do
    subject { get '/recipes/search', params: params }

    let(:params) do
      {
        'ingredients' => 'salt'
      }
    end

    it 'returns http success' do
      subject

      expect(response).to have_http_status(:success)
    end
  end
end
