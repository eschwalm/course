class ChangeAlbumColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :albums, :year, :string
    add_column :albums, :year, :integer
  end
end
