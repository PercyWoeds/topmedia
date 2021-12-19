class CreateMedioCustomers < ActiveRecord::Migration
  def change
    create_table :medio_customers do |t|
      t.integer :medio_id
      t.integer :customer_id
      t.float :comision1
      t.float :comision2

      t.timestamps null: false
    end
  end
end
