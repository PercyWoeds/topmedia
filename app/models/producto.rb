class Producto < ActiveRecord::Base
    belongs_to :marca
    belongs_to :producto 
    
    has_many :versions

    attr_accessible :marca_id, :name, :marca 
    validates_presence_of :name,:marca_id 
    
end
