class AddGrupoToMedios < ActiveRecord::Migration
  def change
    add_column :medios, :grupo, :string
    add_column :medios, :estacion, :string
  end
end
