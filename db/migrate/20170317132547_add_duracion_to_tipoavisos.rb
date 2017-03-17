class AddDuracionToTipoavisos < ActiveRecord::Migration
  def change
    add_column :tipoavisos, :duracion, :float
  end
end
