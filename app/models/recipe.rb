require 'yajl'

class Recipe
  include Id::Model

  field :title
  field :ingredients
  field :href

  def self.find food_items
    data = fetch_data(food_items)
    data.map(&Recipe)      
  end

  private

  def self.fetch_data(food_items)
    Yajl::Parser.parse(Faraday.get(url(food_items)).env[:body])['results'].flatten
  end

  def self.url(food_items)
    "http://www.recipepuppy.com/api/?i=" << food_items.collect { |p| p.title}.join(",")
  end
end
