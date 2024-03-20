class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :admin_id
      t.integer :user_id
      t.integer :status, default: 0, null: false
      t.string :title, null: false
      t.string :facility, null: false
      t.text :point
      t.string :postal_code, null: false
      t.string :address, null: false
      t.float :latitude
      t.float :longitude
      t.string :nearest_station
      t.string :nearest_station_line
      t.text :access
      t.string :telephone_number, null: false
      t.string :open, null: false
      t.integer :average_price, null: false
      t.string :closed, null: false
      t.text :detail_url
      t.text :note
      t.string :star, null: false
      t.timestamps
    end
  end
end
