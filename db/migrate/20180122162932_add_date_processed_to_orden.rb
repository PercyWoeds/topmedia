class AddDateProcessedToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :date_processed, :datetime
  end
end
