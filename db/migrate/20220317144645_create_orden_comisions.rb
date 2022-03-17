class CreateOrdenComisions < ActiveRecord::Migration
  def change
    create_table :orden_comisions do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
