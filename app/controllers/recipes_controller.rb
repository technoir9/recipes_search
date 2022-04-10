# frozen_string_literal: true

class RecipesController < ApplicationController
  INGREDIENTS_SEPARATOR = ','

  def index; end

  def search
    result = Recipes::Search.new(ingredients).call

    render 'index', locals: { search_results: result }
  end

  private

  def ingredients
    params.require(:ingredients).split(INGREDIENTS_SEPARATOR)
  end
end
