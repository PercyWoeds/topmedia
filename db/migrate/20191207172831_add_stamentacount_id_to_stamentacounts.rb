class AddStamentacountIdToStamentacounts < ActiveRecord::Migration
  def change
    add_column :stamentacounts, :stamentacount_id, :integer
  end
end
