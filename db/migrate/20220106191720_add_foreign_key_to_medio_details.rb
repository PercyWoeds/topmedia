class AddForeignKeyToMedioDetails < ActiveRecord::Migration
  def change
    add_reference :medio_details, :medio, index: true 
    add_foreign_key :medio_details, :medios
  end
end
