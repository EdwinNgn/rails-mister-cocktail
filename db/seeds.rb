# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'


Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts "#{Cocktail.count} Cocktails in database"
puts "#{Ingredient.count} Ingredients in database"
puts "#{Dose.count} Doses in database"
# url_ingredients = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
# ingredients_hash = JSON.parse(open(url_ingredients).read)
# ingredients = []
# ingredients_hash['drinks'].each do |ingredient|
#   ingredients << ingredient['strIngredient1']
# end
# ingredients.each do |ingredient|
#   Ingredient.create(name: ingredient)
# end

url_cocktails = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
cocktails_hash = JSON.parse(open(url_cocktails).read)
cocktails = []
cocktails_hash['drinks'].each do |cocktail|
  cocktails << {name: cocktail['strDrink'], image_url: cocktail['strDrinkThumb']}
end
cocktails.each do |cocktail|
  cocktail = Cocktail.new(cocktail)
  url_details = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{cocktail.name.gsub("ó", "o")}"
  details_hash = JSON.parse(open(url_details).read)
  ingredients =[]
  doses = []
  i = 1
  while !details_hash['drinks'].first["strIngredient#{i}"].nil?
    ingredients << details_hash['drinks'].first["strIngredient#{i}"]
    doses << details_hash['drinks'].first["strMeasure#{i}"]
    i += 1
  end
  doses.each_with_index do |element, index|

    ingredient_name = ingredients[index]
    p ingredient_name
    ingredient = Ingredient.where(name: ingredient_name).take
    ingredient = Ingredient.new(name: ingredients[index]) if (ingredient.nil?)
    p ingredient
    dose = Dose.new(description: element)

    p ingredient
    dose.ingredient = ingredient
    ingredient.save
    dose.cocktail = cocktail
    dose.save
    cocktail.save
  end


end




