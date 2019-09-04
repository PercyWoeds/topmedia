class AddCanalToOrdenProducts < ActiveRecord::Migration
  def change
    add_column :orden_products, :canal, :string
	add_column :orden_products, :descrip, :string
	add_column :orden_products, :d, :string
	add_column :orden_products, :h, :string 
	add_column :orden_products, :cantidad, :string 
	add_column :orden_products, :rating, :string 
	add_column :orden_products, :rating2, :string 
	add_column :orden_products, :tpp, :string 
	add_column :orden_products, :impactos, :string 
	add_column :orden_products, :miles, :string 
	add_column :orden_products, :impactos2, :string 
	add_column :orden_products, :cpp, :string 
	add_column :orden_products, :cpm, :string 
	add_column :orden_products, :cmp2, :string 
	
	
  end
end
