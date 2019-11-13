class AddTaxableToMedios < ActiveRecord::Migration
  def change
    add_column :medios, :taxable, :string
  end
end
