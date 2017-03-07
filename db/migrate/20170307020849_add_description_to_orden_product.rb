class AddDescriptionToOrdenProduct < ActiveRecord::Migration
  def change
    add_column :orden_products, :description, :text
  end
end
