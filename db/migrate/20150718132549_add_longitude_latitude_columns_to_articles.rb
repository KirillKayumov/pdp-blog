class AddLongitudeLatitudeColumnsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :longitude, :float, default: 0.0, null: false
    add_column :articles, :latitude, :float, default: 0.0, null: false
  end
end
