# frozen_string_literal: true

class RecipesController < ApplicationController
  INGREDIENTS_SEPARATOR = ','

  def index; end

  def search
    result = Recipes::Search.new(ingredients).call

    render 'index', locals: { search_results: result }
  end

  def export
    result = Recipes::Export.new(ordered_recipes).call

    respond_to do |format|
      format.csv { send_data result, filename: 'recipes_search.csv' }
    end
  end

  private

  def ingredients
    params.require(:ingredients).split(INGREDIENTS_SEPARATOR)
  end

  def ordered_recipes
    recipe_ids.map do |id|
      recipes.detect { |recipe| recipe.id == id.to_i }
    end
  end

  def recipes
    @_recipes ||= Recipe.where(id: recipe_ids).to_a
  end

  def recipe_ids
    @_recipe_ids ||= params.require(:recipe_ids)
  end
end
