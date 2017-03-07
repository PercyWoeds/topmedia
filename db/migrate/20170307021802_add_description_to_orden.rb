class AddDescriptionToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :description, :text
  end
end
