# frozen_string_literal: true

RSpec.describe Recipes::Export do
  describe '#call' do
    subject { described_class.new(recipes).call }

    let(:recipes) { [recipe1, recipe2] }
    let(:recipe1) do
      create(:recipe, title: 'Creamy Peanut Towers',
                      cook_time: 0,
                      prep_time: 5,
                      ingredients: ['2 slices white bread', '2 tablespoons butter', '4 tablespoons peanut butter'],
                      ratings: 4.06,
                      cuisine: '',
                      category: 'Sandwiches',
                      author: 'John Doe',
                      image: 'http://example.com/image1.jpg')
    end
    let(:recipe2) do
      create(:recipe, title: 'Eggs on the Grill',
                      cook_time: 15,
                      prep_time: 2,
                      ingredients: ['12 eggs'],
                      ratings: 4.25,
                      cuisine: '',
                      category: 'Vegetarian Recipes',
                      author: 'Jan Kowalski',
                      image: 'http://example.com/image2.jpg')
    end

    it 'returns recipes data as CSV string' do
      expect(subject).to include(
        'Title,Cook time,Prep time,Ingredients,Ratings,Cuisine,Category,Author,Image',
        'Creamy Peanut Towers,0,5,"2 slices white bread, 2 tablespoons butter, 4 tablespoons peanut butter",4.06,"",Sandwiches,John Doe,http://example.com/image1.jpg',
        'Eggs on the Grill,15,2,12 eggs,4.25,"",Vegetarian Recipes,Jan Kowalski,http://example.com/image2.jpg'
      )
    end
  end
end
