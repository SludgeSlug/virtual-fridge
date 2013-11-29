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
    data = []   
    1.step(5, 1) do |i|
      url = url(food_items) << "&p=" << i.to_s
      data << Yajl::Parser.parse(Faraday.get(url).env[:body])['results'].flatten
    end
    data.flatten
  end

  def self.url(food_items)
    "http://www.recipepuppy.com/api/?i=" << food_items.collect { |p| p.title}.join(",")
  end
end
