class Producto < ActiveRecord::Base
    belongs_to :marca
    belongs_to :producto 
    
    has_many :versions

    attr_accessible :marca_id, :name, :marca 
    validates_presence_of :name,:marca_id 
    



    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Producto.create! row.to_hash 
        end
    end   


end
