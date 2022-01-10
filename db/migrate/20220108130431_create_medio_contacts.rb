class CreateMedioContacts < ActiveRecord::Migration
  def change
    create_table :medio_contacts do |t|
      t.string :code
      t.string :name
      t.string :cargo
      t.string :telefono1
      t.string :telefono2
      t.string :telefono3
      t.string :anexo1
      t.string :anexo2
      t.string :anexo3
      t.string :celular1
      t.string :celular2
      t.string :celular3
      t.string :correo1
      t.string :correo2
      t.references :medio, index: true, foreign_key: true


      t.timestamps null: false
    end
  end
end
