require 'yajl'

class Recipes

  def initialize(params)
    data = fetch_data(params)
    results = data.map(&Recipe)      
  end

  private

  def fetch_data(params)
    Yajl::Parser.parse(Faraday.get(url(params)).env[:body])['results'].flatten
  end

  def url(params)
    "http://www.recipepuppy.com/api/?i=" << params.collect { |p| p.title}.join(",")
  end
end
