class AddAvisoDetailIdToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :aviso_detail_id, :integer
  end
end
