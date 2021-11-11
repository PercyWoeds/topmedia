class MedioDetail < ActiveRecord::Base
   belongs_to :medio

    has_many :orden_products

  attr_accessible :code, :name , :medio_details_attributes

 
end
