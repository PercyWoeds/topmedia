class AddPeliculaToOrdenProducts < ActiveRecord::Migration
  def change
    add_column :orden_products, :pelicula, :string
  end
end
