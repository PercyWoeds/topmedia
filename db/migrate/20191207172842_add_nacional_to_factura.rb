class AddNacionalToFactura < ActiveRecord::Migration
  def change
    add_column :facturas, :nacional, :string
  end
end
