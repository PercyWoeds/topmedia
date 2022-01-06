class RemoveForeignKeyFromMedios < ActiveRecord::Migration
  def change
     remove_reference :medio_details, :medio, index: true, foreign_key: true
  end
end
