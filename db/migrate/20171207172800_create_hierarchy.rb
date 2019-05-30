class CreateHierarchy < ActiveRecord::Migration
  def self.up
    
    
    g1 = Marca.create(:descrip => "Marca 1")
    g2 = Marca.create(:descrip => "Marca 2")
    g3 = Marca.create(:descrip => "Marca 3")

    a1 = Producto.create(:name => "Marca  1", :marca_id => g1.id)
    a2 = Producto.create(:name => "Marca  2", :marca_id => g1.id)
    a3 = Producto.create(:name => "Marca  3", :marca_id => g2.id)
    a4 = Producto.create(:name => "Marca  4", :marca_id => g2.id)
    a5 = Producto.create(:name => "Marca  5", :marca_id => g3.id)
    a6 = Producto.create(:name => "Marca  6", :marca_id => g3.id)

    Version.create(:descrip => "Version 1",  :producto_id => a1.id)
    Version.create(:descrip => "Version 2",  :producto_id => a1.id)
    Version.create(:descrip => "Version 3",  :producto_id => a2.id)
    Version.create(:descrip => "Version 4",  :producto_id => a2.id)
    Version.create(:descrip => "Version 5",  :producto_id => a3.id)
    Version.create(:descrip => "Version 6",  :producto_id => a3.id)
    Version.create(:descrip => "Version 7",  :producto_id => a4.id)
    Version.create(:descrip => "Version 8",  :producto_id => a4.id)
    Version.create(:descrip => "Version 9",  :producto_id => a5.id)
    Version.create(:descrip => "Version 10",  :producto_id => a5.id)
    Version.create(:descrip => "Version 11",  :producto_id => a6.id)
    Version.create(:descrip => "Version 12",  :producto_id => a6.id)
    
    
  end

  def self.down
# you can fill this in if you want.
  end
  
end
