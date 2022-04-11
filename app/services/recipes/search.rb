# frozen_string_literal: true

module Recipes
  class Search
    extend Dry::Initializer

    SELECT_CLAUSE = 'SELECT recipes.*'
    FROM_CLAUSE = 'FROM recipes'
    ORDER_CLAUSE = 'ORDER BY search_results.rank DESC, recipes.id ASC'

    param :ingredients, Dry.Types::Array.of(Dry.Types::String), reader: :private
    option :limit, Dry.Types::Integer, default: -> { 10 }, reader: :private

    def call
      Recipe.find_by_sql(
        [
          SELECT_CLAUSE,
          FROM_CLAUSE,
          join_clause,
          ORDER_CLAUSE,
          limit_clause
        ].join(' ')
      )
    end

    private

    def join_clause
      JoinClause.new(ingredients).call
    end

    def limit_clause
      "LIMIT #{limit}"
    end
  end
end
