# frozen_string_literal: true

module Recipes
  class Export
    extend Dry::Initializer

    HEADERS = [
      'Title',
      'Cook time',
      'Prep time',
      'Ingredients',
      'Ratings',
      'Cuisine',
      'Category',
      'Author',
      'Image'
    ].freeze

    param :recipes, Dry.Types::Array.of(Dry.Types.Instance(Recipe)), reader: :private

    def call
      Csv::Generate.new(HEADERS, rows).call
    end

    private

    def rows
      recipes.map do |recipe|
        [
          recipe.title,
          recipe.cook_time,
          recipe.prep_time,
          recipe.ingredients.join(', '),
          recipe.ratings,
          recipe.cuisine,
          recipe.category,
          recipe.author,
          recipe.image
        ]
      end
    end
  end
end
