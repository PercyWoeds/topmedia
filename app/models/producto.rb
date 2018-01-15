class Producto < ActiveRecord::Base
    belongs_to :marca
    belongs_to :producto 
    
    has_many :versions

    attr_accessible :marca_id, :name, :marca 
    
end
