class ChangeColumnNameFromType < ActiveRecord::Migration[5.2]
  def change
    rename_column :beers, :type, :beer_style
  end
end
