class AddStamentacountIdToStamentacountDetails < ActiveRecord::Migration
  def change
    add_column :stamentacount_details, :stamentacount_id, :integer
  end
end
