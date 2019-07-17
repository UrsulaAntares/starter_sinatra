class CreateBrewery < ActiveRecord::Migration[5.2]
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :location
      t.string :blurb
    end
    create_table :beers do |t|
      t.string :name
      t.integer :brewery_id
      t.string :blurb
    end
  end
end
