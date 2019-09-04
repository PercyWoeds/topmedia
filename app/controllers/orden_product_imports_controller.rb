class OrdenProductImportsController < ApplicationController
 
 def new
    @product_import = OrdenProductImport.new
    
  end


  def create
    @product_import = OrdenProductImport.new(params[:product_import])
    if @product_import.save
      redirect_to root_url, notice: "Imported products successfully."
    else
      render :new
    end
 end 

end
