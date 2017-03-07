module AvisodetailsHelper
  def checkProducts()
    if(params[:company_id])
      product = Avisodetail.where(company_id: params[:company_id])
    
      if(not product)
        flash[:error] = "Please create a program first."
        redirect_to "/products/new/#{params[:company_id]}"
      end
    end
  end


end
