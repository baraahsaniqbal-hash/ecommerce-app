class AddStatusToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :status, :integer, default: 0, null: false
  end
end
