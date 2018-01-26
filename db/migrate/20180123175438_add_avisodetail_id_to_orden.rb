class AddAvisodetailIdToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :avisodetail_id, :integer
  end
end
