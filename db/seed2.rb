# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
3.times do |x|
  genre  = Marca.find_or_create_by_name(:name => "Marca #{x}")
  3.times do |y|
    artist = Version.find_or_create_by_name(:name => "Version #{x}.#{y}", :genre => genre)
    3.times do |z|
      Producto.find_or_create_by_title(:title => "Producto #{x}.#{y}.#{z}",  :artist => artist)
    end
  end
end
