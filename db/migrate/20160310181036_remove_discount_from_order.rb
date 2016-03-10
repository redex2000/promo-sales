class RemoveDiscountFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :discount
  end
end
