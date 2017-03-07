class AddProcessedToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :processed, :string
  end
end
