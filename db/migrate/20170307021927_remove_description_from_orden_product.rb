class RemoveDescriptionFromOrdenProduct < ActiveRecord::Migration
  def change
    remove_column :orden_products, :description, :text
  end
end
