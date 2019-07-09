class AddSecuContToOrdens < ActiveRecord::Migration
  def change
    add_column :ordens, :secu_cont, :string
  end
end
