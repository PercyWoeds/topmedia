class AddMonthToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :month, :integer
  end
end
