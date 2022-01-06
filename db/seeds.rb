# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


# 3.times do |x|
#   genre  = Marca.find_or_create_by(:name => "Marca #{x}")
#   puts "marca"
#   puts genre.id 
#   3.times do |y|
#     artist = Producto.find_or_create_by(:name => "Producto #{x}.#{y}", :marca_id => genre.id)
#     puts "version"
#     puts artist.id 
#     3.times do |z|
#       Version.find_or_create_by(:descrip => "Version #{x}.#{y}.#{z}",  :producto_id => artist.id)
#     end
#   end
# end

# a = User.new(username: "Percy", level: "admin", first_name: "Percy", last_name: "Chavez", email: "percywoeds@gmail.com", password: "ycrep2016",password_confirmation:"ycrep2016") 
# a.save

# a= Company.new(user_id: 1, name: "MADUEÑO SAC", address1: "MIRAFLORES", address2: "LIMA", city: "LIMA", state:"LIMA", zip: "51", country: "PERU", website: "www.masa.pe", phone1: ".", phone2: "", email: "percywoeds@gmail.com",ruc:"20100105609" )
# a.save

# a= CompanyUser.new(user_id: 1,company_id: 1)
# a.save

a = User.new(username:"Daniel Herrera",level:"admin2",first_name:"Daniel", last_name:"Herrera",
  email:"danielh@massmedia.pe",password:"danielherrera2022",password_confirmation:"danielherrera2022")
a.save

a = User.new(username:"Leyla Ocmin",level:"admin1",first_name:"Leyla", last_name:"Ocmin",
  email:"leylao@massmedia.pe",password:"Leylaocmin2022",password_confirmation:"Leylaocmin2022")
a.save

a = User.new(username:"Silvana Cesperes",level:"admin1",first_name:"Silvana", last_name:"Cespedes",
  email:"silvana.cespedes@topmedia.com.pe",password:"silvana2022",password_confirmation:"silvana2022")
a.save

a = User.new(username:"Luz Rodriguez",level:"admin2",first_name:"Luz", last_name:"Rodriguez",
  email:"luz.rodriguezv@massmedia.pe",password:"luzrodri2022",password_confirmation:"luzrodri2022")
a.save


a = User.new(username:"Eduardo Cortavitarte",level:"planner",first_name:"Eduardo", last_name:"Cortavitarte",
  email:"eduardoc@massmedia.pe",password:"eduardo2022",password_confirmation:"eduardo2022")
a.save


a = User.new(username:"German Camones",level:"planner",first_name:"German", last_name:"Camones",
  email:"germanc@massmedia.pe",password:"german2022",password_confirmation:"german2022")
a.save


a = User.new(username:"Renato Perazzo",level:"planner",first_name:"Renato", last_name:"Perazzo",
  email:"renato.perazzo@topmedia.com.pe",password:"renato2022",password_confirmation:"renato2022")
a.save

a = User.new(username:"Blanca Reyes",level:"planner",first_name:"Blanca", last_name:"Reyes",
  email:"blancar@massmedia.pe",password:"blanca2022",password_confirmation:"blanca2022")
a.save






