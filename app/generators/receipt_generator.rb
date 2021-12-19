require_relative 'document_generator'

class ReceiptGenerator < InvoiceGenerator

  def customer
    
  
    {legal_name: $lcLegalName , dni:  $lcRuc }
  
  end

  def document_class
    SUNAT::Receipt
  end
end