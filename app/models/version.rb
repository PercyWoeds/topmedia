class Version < ActiveRecord::Base
    
    belongs_to :producto
    



    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Version.create! row.to_hash 
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

   def self.search(search)
    # Title is for the above case, the OP incorrectly had 'name'
      
    
         where("descrip ILIKE ?", "%#{search}%") 
          
    end



end
