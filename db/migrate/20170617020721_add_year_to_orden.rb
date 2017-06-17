class AddYearToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :year, :integer
  end
end
