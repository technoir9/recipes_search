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

  describe 'GET /export' do
    subject { get '/recipes/export', params: params }

    let(:params) do
      {
        'recipe_ids' => [recipe1.id.to_s, recipe2.id.to_s, recipe3.id.to_s],
        'format' => 'csv'
      }
    end
    let(:recipe1) { create(:recipe, ingredients: ['10 eggs', 'sugar', 'salt']) }
    let(:recipe2) { create(:recipe, ingredients: ['5 eggs']) }
    let(:recipe3) { create(:recipe, ingredients: ['egg', 'sugar']) }

    it 'returns http success' do
      subject

      expect(response).to have_http_status(:success)
    end

    it 'returns a CSV file' do
      subject

      expect(response.body).to include(
        'Title,Cook time,Prep time,Ingredients,Ratings,Cuisine,Category,Author,Image',
        recipe1.title,
        recipe2.title,
        recipe3.title
      )
    end
  end
end
