class ContratoDetail < ActiveRecord::Base
    validates_presence_of :importe ,:nro ,:fecha 
    
    belongs_to :contrato 
    has_many :factura_detail
end
