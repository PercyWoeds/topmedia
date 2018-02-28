class Marca < ActiveRecord::Base
  
  has_many :productos
  has_many :versions, :through => :productos
    
end
