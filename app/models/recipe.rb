require 'yajl'

class Recipe
  include Id::Model

  field :title
  field :ingredients
  field :href

  def self.find food_items
    data = fetch_data(food_items)
    sort_recipes(data.map(&Recipe), food_items)
  end

  private

  def self.fetch_data(food_items)  
    data = []   
    1.step(5, 1) do |i|
      url = url(food_items) << "&p=" << i.to_s
      data << Yajl::Parser.parse(Faraday.get(url).env[:body])['results'].flatten
    end
    data.flatten
  end

  def self.url(food_items)
    "http://www.recipepuppy.com/api/?i=" << list_of_ingredients(food_items).join(",")
  end

  def self.list_of_ingredients(food_items)
    food_items.collect { |p| p.title }
  end

  def self.sort_recipes(recipes, available_ingredients)
    recipes.sort_by! { |r| percentage_of_available_ingredients(r.ingredients.split(','), list_of_ingredients(available_ingredients)) }
  end

  def self.percentage_of_available_ingredients(ingredients, available_ingredients)
    number_available_for_recipe = 0
    ingredients.each do |i|
      if available_ingredients.include? i
        number_available_for_recipe += 1
      end
    end

    if ingredients.count != 0
      number_available_for_recipe / ingredients.count
    else
      0
    end
  end

end
