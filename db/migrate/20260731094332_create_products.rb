class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true

      t.string :name, null: false
      t.string :slug
      t.text :description

      t.decimal :price, precision: 10, scale: 2, null: false

      t.string :sku, null: false

      t.integer :stock, default: 0, null: false

      t.integer :status, default: 1, null: false

      t.timestamps
    end

    add_index :products, :slug, unique: true
    add_index :products, :sku, unique: true
  end
end