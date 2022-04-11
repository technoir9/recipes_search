# frozen_string_literal: true

RSpec.describe Recipes::Search do
  describe '#call' do
    subject { described_class.new(ingredients).call }

    let(:ingredients) { ['egg'] }
    let!(:recipe1) { create(:recipe, ingredients: ['10 eggs', 'sugar', 'salt']) }
    let!(:recipe2) { create(:recipe, ingredients: ['5 eggs']) }
    let!(:recipe3) { create(:recipe, ingredients: ['egg', 'sugar']) }

    it 'returns most relevant recipes' do
      expect(subject).to eq([
        recipe2,
        recipe3,
        recipe1
      ])
    end

    context 'with limit specified' do
      subject { described_class.new(ingredients, limit: limit).call }

      let(:limit) { 2 }

      it 'returns most relevant recipes' do
        expect(subject).to eq([
          recipe2,
          recipe3
        ])
      end
    end
  end
end
