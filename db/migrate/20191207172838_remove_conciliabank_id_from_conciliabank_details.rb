class RemoveConciliabankIdFromConciliabankDetails < ActiveRecord::Migration
  def change
    remove_column :conciliabank_details, :conciliabank_id, :string
  end
end
