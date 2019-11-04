class AddCargosToConciliabanks < ActiveRecord::Migration
  def change
    add_column :conciliabanks, :cargos, :float
    add_column :conciliabanks, :abonos, :float
    
  end
end
