class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :image
      t.string :title
      t.text :description
      t.string :email
      t.string :city
      t.string :address

      t.timestamps
    end
  end
end
