class AddMedioIdToFactura < ActiveRecord::Migration
  def change
    add_column :facturas, :medio_id, :integer
  end
end
