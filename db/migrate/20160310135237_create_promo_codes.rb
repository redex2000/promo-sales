class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :promo_codes do |t|
      t.string :code, null: false
      t.float :discount_sum, null: false
      t.integer :count, default: -1

      t.timestamps null: false
    end
  end
end
