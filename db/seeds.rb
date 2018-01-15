# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


3.times do |x|
  genre  = Marca.find_or_create_by(:name => "Marca #{x}")
  puts "marca"
  puts genre.id 
  3.times do |y|
    artist = Producto.find_or_create_by(:name => "Producto #{x}.#{y}", :marca_id => genre.id)
    puts "version"
    puts artist.id 
    3.times do |z|
      Version.find_or_create_by(:descrip => "Version #{x}.#{y}.#{z}",  :producto_id => artist.id)
    end
  end
end
