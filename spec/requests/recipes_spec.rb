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
        'ingredients' => 'sugar'
      }
    end
    let!(:recipe1) { create(:recipe, title: 'Recipe 1', ingredients: ['10 eggs', 'sugar', 'salt']) }
    let!(:recipe2) { create(:recipe, title: 'Recipe 2', ingredients: ['5 eggs']) }
    let!(:recipe3) { create(:recipe, title: 'Recipe 3', ingredients: ['egg', 'sugar']) }

    it 'returns http success' do
      subject

      expect(response).to have_http_status(:success)
    end

    it 'renders view with search results' do
      subject

      expect(response.body).to include(
        'Search results for the following ingredients: sugar',
        recipe1.title,
        recipe3.title
      )
      expect(response.body).not_to include(
        recipe2.title
      )
    end

    context 'with pagination' do
      let(:params) do
        {
          'ingredients' => 'eggs',
          'page' => 2,
          'per_page' => 2
        }
      end

      it 'returns http success' do
        subject

        expect(response).to have_http_status(:success)
      end

      it 'renders view with search results' do
        subject

        expect(response.body).to include(
          'Search results for the following ingredients: eggs',
          recipe1.title
        )
        expect(response.body).not_to include(
          recipe2.title,
          recipe3.title
        )
      end
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
