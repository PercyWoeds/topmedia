class CreateTipoTarifas < ActiveRecord::Migration
  def change
    create_table :tipo_tarifas do |t|
      t.string :code
      t.string :name
      t.string :user_id

      t.timestamps null: false
    end
  end
end
