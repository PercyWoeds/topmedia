class AddConciliaIdToConciliabankDetails < ActiveRecord::Migration
  def change
    add_column :conciliabank_details, :conciliabank_id, :integer
  end
end
