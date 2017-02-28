class Quote < ActiveRecord::Base

	belongs_to :contrato 

	belongs_to :customer 

end
