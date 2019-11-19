class AddStatusToOrdens < ActiveRecord::Migration
  def change
    add_column :ordens, :status, :string
  end
end
