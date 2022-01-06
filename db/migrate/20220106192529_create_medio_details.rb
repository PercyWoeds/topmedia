class CreateMedioDetails < ActiveRecord::Migration
  def change
    create_table :medio_details do |t|
      t.string :code
      t.string :name
      t.integer :user_id
      t.integer :medio_id
      t.references :medio, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
