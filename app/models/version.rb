class Version < ActiveRecord::Base
    
    belongs_to :producto
    attr_accessible :producto_id, :title, :producto 
end
