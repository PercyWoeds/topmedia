class Medio < ActiveRecord::Base
  
  validates_uniqueness_of :estacion 
	validates_presence_of :descrip,:grupo,:estacion

	belongs_to :contrato 
	belongs_to :orden
  belongs_to :factura 
  


  has_many :medio_details , dependent: :destroy
  has_many :medio_contacts , dependent: :destroy

 accepts_nested_attributes_for :medio_details  , reject_if: proc { |att| att['name'].blank?} , :allow_destroy => true
 accepts_nested_attributes_for :medio_contacts , reject_if: proc { |att| att['name'].blank?} , :allow_destroy => true



    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Medio.create! row.to_hash 
        end
    end      
 
  
end
