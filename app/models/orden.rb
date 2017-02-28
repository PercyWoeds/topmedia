class Orden < ActiveRecord::Base

	belongs_to :contrato
	belongs_to :medio
	belongs_to :marca
	belongs_to :version

end
