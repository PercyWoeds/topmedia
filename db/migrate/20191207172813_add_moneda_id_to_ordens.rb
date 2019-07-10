class AddMonedaIdToOrdens < ActiveRecord::Migration
  def change
    add_column :ordens, :moneda_id, :integer
  end
end
