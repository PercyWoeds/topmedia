class AddAddress1ToMedios < ActiveRecord::Migration
  def change
    add_column :medios, :address1, :string
    
    
  end
end
