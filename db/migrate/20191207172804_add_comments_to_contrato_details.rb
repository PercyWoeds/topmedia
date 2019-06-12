class AddCommentsToContratoDetails < ActiveRecord::Migration
  def change
    add_column :contrato_details, :comments, :text
  end
end
