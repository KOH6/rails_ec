class CreatePromotionCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :promotion_codes do |t|
      t.string :code, null: false
      t.integer :discount, null: false
      t.references :order, null: true, foreign_key: true

      t.timestamps
    end
    add_index :promotion_codes, :code, unique: true
  end
end