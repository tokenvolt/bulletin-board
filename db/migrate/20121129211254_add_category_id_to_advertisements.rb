class AddCategoryIdToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :category_id, :integer
  end
end
