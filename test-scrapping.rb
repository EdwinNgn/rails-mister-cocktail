require 'open-uri'
require 'json'
# Cocktail.destroy_all
# url_ingredients = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
# ingredients_hash = JSON.parse(open(url_ingredients).read)
# ingredients = []
# ingredients_hash['drinks'].each do |ingredient|
#   ingredients << ingredient['strIngredient1']
# end
# ingredients.each do |ingredient|
#   Ingredient.create(name: ingredient)
# end

# url_cocktails = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic"
# cocktails_hash = JSON.parse(open(url_cocktails).read)
# cocktails = []
# cocktails_hash['drinks'].each do |cocktail|
#   cocktails << {name: cocktail['strDrink'], image_url: cocktail['strDrinkThumb']}
# end
# cocktails.each do |cocktail|
  url_details = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=1-900-FUK-MEUP"
  details_hash = JSON.parse(open(url_details).read)
  ingredients =[]
  doses = []
  i = 1
  while !details_hash['drinks'].first["strIngredient#{i}"].nil?
    ingredients << details_hash['drinks'].first["strIngredient#{i}"]
    doses << details_hash['drinks'].first["strMeasure#{i}"]
    i += 1
  end

  puts ingredients
  puts doses
# end
