pdf.font "Helvetica"


pdf.text "Company: #{@orden.company.name}", :size => 18, :style => :bold, :spacing => 4

pdf.text "______________________________________________________________________", :size => 13, :spacing => 4
pdf.text " ", :size => 13, :spacing => 4

pdf.text "orden: #{@orden.identifier}", :size => 18, :style => :bold, :spacing => 4

pdf.text "______________________________________________________________________", :size => 13, :spacing => 4
pdf.text " ", :size => 13, :spacing => 4

pdf.text "Code: #{@orden.code}", :size => 13, :spacing => 4

pdf.text "______________________________________________________________________", :size => 13, :spacing => 4
pdf.text " ", :size => 13, :spacing => 4

pdf.text "Subtotal: $#{money(@orden.subtotal)}", :size => 15, :style => :bold, :spacing => 4
pdf.text "Tax: $#{money(@orden.tax)}", :size => 15, :style => :bold, :spacing => 4
pdf.text "Total: $#{money(@orden.total)}", :size => 15, :style => :bold, :spacing => 4

pdf.text "______________________________________________________________________", :size => 13, :spacing => 4
pdf.text " ", :size => 13, :spacing => 4

pdf.text "Customer information", :size => 15, :style => :bold, :spacing => 4
pdf.text " ", :size => 13, :spacing => 4

pdf.text "Name: #{@orden.customer.name}", :size => 13, :spacing => 4

if @orden.customer.email and @orden.customer.email != ""
  pdf.text "Email: #{@orden.customer.email}", :size => 13, :spacing => 4
end

if @orden.customer.account and @orden.customer.account != ""
  pdf.text "Account: #{@orden.customer.account}", :size => 13, :spacing => 4
end

if @orden.customer.phone1 and @orden.customer.phone1 != ""
  pdf.text "Phone 1: #{@orden.customer.phone1}", :size => 13, :spacing => 4
end

if @orden.customer.phone2 and @orden.customer.phone2 != ""
  pdf.text "Phone 2: #{@orden.customer.phone2}", :size => 13, :spacing => 4
end

if @orden.customer.address1 and @orden.customer.address1 != ""
  pdf.text "Address 1: #{@orden.customer.address1}", :size => 13, :spacing => 4
end

if @orden.customer.address2 and @orden.customer.address2 != ""
  pdf.text "Address 2: #{@orden.customer.address2}", :size => 13, :spacing => 4
end

if @orden.customer.city and @orden.customer.city != ""
  pdf.text "City: #{@orden.customer.city}", :size => 13, :spacing => 4
end

if @orden.customer.state and @orden.customer.state != ""
  pdf.text "State: #{@orden.customer.state}", :size => 13, :spacing => 4
end

if @orden.customer.zip and @orden.customer.zip != ""
  pdf.text "ZIP: #{@orden.customer.zip}", :size => 13, :spacing => 4
end

if @orden.customer.country and @orden.customer.country != ""
  pdf.text "Country: #{@orden.customer.country}", :size => 13, :spacing => 4
end

pdf.text "______________________________________________________________________", :size => 13, :spacing => 4
pdf.text " ", :size => 13, :spacing => 4

pdf.text "Details", :size => 15, :style => :bold, :spacing => 4
pdf.text " ", :size => 13, :spacing => 4

for product in @orden.get_products()
  pdf.text "#{product.name} - Price: $#{money(product.price)} - Quantity: #{product.quantity} - Discount: #{money(product.discount)} - Total: $#{money(product.total)}", :size => 13, :spacing => 4
end

pdf.text " ", :size => 13, :spacing => 4

pdf.text "Subtotal: $#{money(@orden.subtotal)}", :size => 13, :spacing => 4
pdf.text "Tax: $#{money(@orden.tax)}", :size => 13, :spacing => 4
pdf.text "Total: $#{money(@orden.total)}", :size => 13, :spacing => 4

pdf.draw_text "Company: #{@orden.company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]