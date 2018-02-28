class AddFullNameToMedios < ActiveRecord::Migration
  def change
    add_column :medios, :full_name, :string
  end
end
