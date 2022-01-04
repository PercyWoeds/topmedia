class CreateTipoCpms < ActiveRecord::Migration
  def change
    create_table :tipo_cpms do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
