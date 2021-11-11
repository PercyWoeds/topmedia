class AddMedioDetailIdToOrdenProducts < ActiveRecord::Migration
  def change
    add_column :orden_products, :medio_detail_id, :integer
  end
end
