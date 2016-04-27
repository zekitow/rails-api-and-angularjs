class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string  :name
      t.string  :address
      t.integer :star_rating
      t.string  :accomodation_type

      t.timestamps null: false
    end
    add_index :hotels, :name
    add_index :hotels, :address
  end
end
