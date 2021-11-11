class Medio < ActiveRecord::Base
  
  validates_uniqueness_of :estacion 
	validates_presence_of :descrip,:grupo,:estacion

	belongs_to :contrato 
	belongs_to :orden
  belongs_to :factura 

  has_many :medio_details , dependent: :destroy

 accepts_nested_attributes_for :medio_details , reject_if: proc { |att| att['name'].blank?} , :allow_destroy => true

 
  
end
