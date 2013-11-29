class CreateFoodItems < ActiveRecord::Migration
  def change
    create_table :food_items do |t|
      t.string :title
      t.string :expiry_date

      t.timestamps
    end
  end
end
