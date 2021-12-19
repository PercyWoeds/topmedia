class MedioCustomer < ActiveRecord::Base

	belongs_to :customer 
	belongs_to :medio

end
