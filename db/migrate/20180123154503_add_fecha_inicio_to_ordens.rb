class AddFechaInicioToOrdens < ActiveRecord::Migration
  def change
    add_column :ordens, :fecha_inicio, :datetime
    add_column :ordens, :fecha_fin,  :datetime
  end
end
