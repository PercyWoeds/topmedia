class AddTcToFacturas < ActiveRecord::Migration
  def change
    add_column :facturas, :tc, :string
  end
end
