class AddPriceToLineItmes < ActiveRecord::Migration[5.1]
  def up
    add_column :line_items, :price, :decimal

    LineItem.all.each do |line_item|
      corresponding_product = Product.find_by(id: line_item.product_id)
      line_item.price = corresponding_product.price
      line_item.save!
    end
  end

  def down
    remove_column :line_items, :price
  end
end
