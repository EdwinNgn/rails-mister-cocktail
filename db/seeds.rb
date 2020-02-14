# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

def upload_image(url, photo_name, cocktail)
  photo_file = URI.open(url)
  cocktail.photo.attach(io: photo_file, filename: "#{photo_name}.jpg", content_type: 'image/jpg')
end


Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts "#{Cocktail.count} Cocktails in database"
puts "#{Ingredient.count} Ingredients in database"
puts "#{Dose.count} Doses in database"

###########################
('a'..'z').each do |letter|
  url_cocktails = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}"
  cocktails_hash = JSON.parse(open(url_cocktails).read)
  if !cocktails_hash['drinks'].nil?
    cocktails_hash['drinks'].each_with_index do |cocktail_hash, index|

      cocktail = Cocktail.new({ name: cocktail_hash['strDrink']})
      photo_url = cocktail_hash['strDrinkThumb']
      p photo_url

      upload_image(photo_url, cocktail_hash['strDrink'], cocktail)

      ingredients = []
      doses = []
      i = 1
      while !cocktails_hash['drinks'][index]["strIngredient#{i}"].nil?
        ingredients << cocktails_hash['drinks'][index]["strIngredient#{i}"]
        doses << cocktails_hash['drinks'][index]["strMeasure#{i}"]
        i += 1
      end
      if !doses.nil?
        doses.each_with_index do |element, index|
          ingredient_name = ingredients[index]
          ingredient = Ingredient.where(name: ingredient_name).take
          ingredient = Ingredient.new(name: ingredients[index]) if ingredient.nil?
          dose = Dose.new(description: element)

          dose.ingredient = ingredient
          ingredient.save
          dose.cocktail = cocktail
          dose.save
          cocktail.save
          puts "#{Cocktail.count} Cocktails in database"
        end
      end
    end
  end
end




