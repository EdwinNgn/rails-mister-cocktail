class CocktailsController < ApplicationController
  def index
    if params[:ingredient_select].blank?
      @cocktails = Cocktail.all
    else
      ingredient = Ingredient.where(name: params[:ingredient_select])
      doses = Dose.where(ingredient: ingredient).to_a
      @cocktails = []
      doses.each do |dose|
        @cocktails << dose.cocktail
      end
    end
    # ingredient.where(name: ingredient_select)
    #chercher les doses avec l'ingredient
    #ajouter a l'array vide avec les dose.cocktail
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
    # @doses = @cocktail.doses
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktails_path
    else
      render :new
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
