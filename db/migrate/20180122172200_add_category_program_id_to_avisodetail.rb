class AddCategoryProgramIdToAvisodetail < ActiveRecord::Migration
  def change
    add_column :avisodetails, :category_program_id, :integer
  end
end
