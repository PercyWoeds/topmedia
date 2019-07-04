class AddFecha3ToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :fecha3, :datetime
  end
end
