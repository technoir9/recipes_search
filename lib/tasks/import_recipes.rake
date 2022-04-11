# frozen_string_literal: true

task 'import_recipes' => :environment do
  puts 'Downloading recipes...'

  RECIPES_URI = URI(ENV.fetch('RECIPES_URL'))
  recipes_archive = Net::HTTP.get(RECIPES_URI)

  puts 'Parsing recipes...'
  recipes_json = Zlib::GzipReader.new(StringIO.new(recipes_archive)).read
  recipes = JSON.parse(recipes_json)

  puts 'Importing recipes...'
  Recipe.create_with(created_at: Time.zone.now, updated_at: Time.zone.now).insert_all!(recipes)

  puts 'Finished!'
end
