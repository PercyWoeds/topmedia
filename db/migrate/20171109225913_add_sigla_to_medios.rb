class AddSiglaToMedios < ActiveRecord::Migration
  def change
    add_column :medios, :sigla, :string
    add_column :medios, :address, :text
    add_column :medios, :phone1, :string
    add_column :medios, :atencion, :string
    add_column :medios, :ruc, :string
    add_column :medios, :active, :string
  end
end
