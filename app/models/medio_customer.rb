class MedioCustomer < ActiveRecord::Base

	belongs_to :customer 
	belongs_to :medio
	belongs_to :orden_comision 

end
