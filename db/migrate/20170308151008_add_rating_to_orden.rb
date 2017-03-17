class AddRatingToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :rating, :string
  end
end
