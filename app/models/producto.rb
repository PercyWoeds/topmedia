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



  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |result|
        csv << result.attributes.values_at(*column_names)
      end
    end

    
  end


end
