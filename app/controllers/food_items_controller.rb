class FoodItemsController < ApplicationController

  def new
  end

  def create
    @food_item = FoodItem.new(food_item_params)
    @food_item.save
    redirect_to @food_item
  end

  def show
    @food_item = FoodItem.find(params[:id])
  end

  def index
    @food_items = FoodItem.all
    @recipes = Recipe.find(FoodItem.all)
  end

  def edit
    @food_item = FoodItem.find(params[:id])
  end

  def update
    @food_item = FoodItem.find(params[:id])
    
    if @food_item.update(params[:food_item])
      redirect_to @food_item
    else
      render 'edit'
    end
  end

  def destroy
    @food_item = FoodItem.find(params[:id])

    @food_item.destroy
    redirect_to food_items_path
  end

  private

  def food_item_params
    params.require(:food_item).permit(:title,:expiry_date)
  end
end
