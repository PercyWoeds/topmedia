class CreateTipoAvisos < ActiveRecord::Migration
  def change
    create_table :tipo_avisos do |t|
      t.string :code
      t.string :name
      t.string :user_id

      t.timestamps null: false
    end
  end
end
