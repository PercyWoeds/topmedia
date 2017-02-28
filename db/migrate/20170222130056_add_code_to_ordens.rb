class AddCodeToOrdens < ActiveRecord::Migration
  def change
    add_column :ordens, :code, :string
  end
end
