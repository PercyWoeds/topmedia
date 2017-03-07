class AddCompanyIdToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :company_id, :integer
  end
end
