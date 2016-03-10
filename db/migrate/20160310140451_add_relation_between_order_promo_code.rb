class AddRelationBetweenOrderPromoCode < ActiveRecord::Migration
  def change
    remove_column :orders, :promo_code
    add_reference :orders, :promo_code, index: true, foreign_key: true
  end
end
