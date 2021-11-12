class TipoAviso < ActiveRecord::Base

	has_many :tipo_avisos
	has_many :tipo_tarifas
	
end
