# frozen_string_literal: true

module Recipes
  class Search
    extend Dry::Initializer

    ORDER_CLAUSE = 'search_results.rank DESC, recipes.id ASC'

    param :ingredients, Dry.Types::Array.of(Dry.Types::String), reader: :private

    def call
      Recipe.joins(join_clause)
            .order(ORDER_CLAUSE)
    end

    private

    def join_clause
      JoinClause.new(ingredients).call
    end
  end
end
