class AddCodeToMedios < ActiveRecord::Migration
  def change
    add_column :medios, :code, :string
  end
end
