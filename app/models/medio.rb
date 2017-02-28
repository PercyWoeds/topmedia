class Medio < ActiveRecord::Base

	
	belongs_to :contrato 
	belongs_to :orden
	
end
