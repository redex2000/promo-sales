class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :description, null: false
      t.float :cost, null: false
      t.float :discount, default: 1.0
      t.string :ip, limit: 15, null: false
      t.string :promo_code, default: nil

      t.timestamps null: false

      t.index :promo_code, unique: true
    end
  end
end
