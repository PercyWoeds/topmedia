class Marca < ActiveRecord::Base
  belongs_to :customer 
  
  has_many :productos
  has_many :versions, :through => :productos
  
  validates_presence_of :name,:customer_id
  


    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Marca.create! row.to_hash 
        end
    end   



end
