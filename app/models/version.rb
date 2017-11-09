class Version < ActiveRecord::Base
	belongs_to :orden
	
	validates_uniqueness_of :descrip 
end
