class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :movies, :trating, :rating
  end
end
