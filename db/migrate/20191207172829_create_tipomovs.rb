class CreateTipomovs < ActiveRecord::Migration
  def change
    create_table :tipomovs do |t|
      t.string :code
      t.string :descrip
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
