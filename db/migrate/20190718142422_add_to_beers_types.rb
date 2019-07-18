class AddToBeersTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :type, :string
    add_column :beers, :short_type, :string
    add_column :beers, :style_id, :integer
    add_column :beers, :icon, :string
    add_column :beers, :link, :string
  end
end
