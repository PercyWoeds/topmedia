class AddMotivoToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :motivo, :string
  end
end
