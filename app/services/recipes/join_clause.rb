# frozen_string_literal: true

module Recipes
  class JoinClause
    extend Dry::Initializer

    FROM_CLAUSE = 'FROM recipes'
    TS_VECTOR = "to_tsvector('english', coalesce(recipes.ingredients::text, ''))"

    param :ingredients, Dry.Types::Array.of(Dry.Types::String), reader: :private

    def call
      "INNER JOIN (#{subquery}) AS search_results ON recipes.id = search_results.id"
    end

    private

    def subquery
      [
        select_clause,
        FROM_CLAUSE,
        where_clause
      ].join(' ')
    end

    def select_clause
      "SELECT recipes.id AS id, #{rank}"
    end

    def rank
      "ts_rank((#{TS_VECTOR}), (#{ts_query}), 1) AS rank"
    end

    def where_clause
      "WHERE ((#{TS_VECTOR}) @@ (#{ts_query}))"
    end

    def ts_query
      @_ts_query ||= ingredients.map do |ingredient|
        "plainto_tsquery('english', #{sanitize(ingredient)})"
      end.join(' || ')
    end

    def sanitize(str)
      ActiveRecord::Base.connection.quote(str)
    end
  end
end
