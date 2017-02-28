class Marca < ActiveRecord::Base

	validates_presence_of  :descrip

  belongs_to :company
  belongs_to :orden
  
  
  has_many :trucks
  has_many :products
  

end
