class ContratoDetail < ActiveRecord::Base
    belongs_to :contrato 
    has_many :factura_detail
end
